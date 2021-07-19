//
//  MapView.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import UIKit
import CoreLocation

class MapView: UIViewController{
    
    // MARK: - Dependency Injection
    /*
             - mapViewModelDelegate
             - LocationManagerDelegate
     */
    var viewModel: mapViewModelDelegate
    var locationManagerDelegate:LocationManagerDelegate
    init(ViewModel: MapViewViewModel = MapViewViewModel(),
         locationManager:LocationManagerDelegate = LocationManager()) {
        viewModel = ViewModel
        locationManagerDelegate = locationManager
        super.init(nibName: nil, bundle: nil)
        viewModel.mapViewDelegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: app life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("📲 MainView view did load")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("📱 MainView view did appear")
        initSetup()
    }
    
    
    // MARK: Properties
    var userLocationMarker = NTMarker()
    var timer: Timer?

    
    // MARK: Parameteres
    // MARK: Marker Vector Element Layer
    // User Location Marker Layer ( Live User Location Pin )
    var userLocationMarkerLayer = NTVectorElementLayer()
    // Route Location Marker Layer ( Destination Location Pin)
    var destinationMarkerLayer = NTVectorElementLayer()
    // Route Shape Marker Layer ( Route Pin)
    var routeShapeLayer = NTVectorElementLayer()
    
    
    //MARK: UI Element
    
    //  Map User Interface Objects
    var mapView: NTMapView = NTMapView()
    var BASE_MAP_INDEX: Int32 = 0
    let TRAFFIC_INDEX: Int32 = 1

    //  live location button element
    var liveLocationButton:UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "Location"), for: .normal)
        return button
    }()
    
    //  route info container View
    var billboardContainerView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    var searchContainerView:UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
        
    //MARK: initSetup
    fileprivate func initSetup(){
        setupUIView()
        setupUILayout()
        setupBillboardView()
        setupSearchView()
        setupMapView()
        setupLocationManager()
        setupMapEventListener()
    }
    
    // MARK: Setup UI View
    //       Add UI element to view
    fileprivate func setupUIView(){
        view.addSubview(mapView)
        view.addSubview(searchContainerView)
        view.addSubview(billboardContainerView)
        print("✅ MapView : setup UIViews Completed.")
    }
    
    // MARK: Setup UI Layout
    fileprivate func setupUILayout(){
        
        mapView.anchor(top: self.view.topAnchor,
                        left: self.view.leftAnchor,
                        bottom: self.view.bottomAnchor,
                        right: self.view.rightAnchor,
                        paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0)
        
        billboardContainerView.anchor(top: view.bottomAnchor,
                                      left: view.leftAnchor,
                                      right: view.rightAnchor,
                                      paddingLeft: 0.0,paddingRight: 0.0,
                                      height: 250, cornerRadius: 16)
        
        searchContainerView.anchor(top: view.bottomAnchor,
                                   left: view.leftAnchor,
                                   right: view.rightAnchor,
                                   paddingLeft: 0.0,paddingRight: 0.0,
                                   height: view.frame.height)
        
        print("✅ MapView : setup UILayouts completed.")
    }
    
    
    // MARK: Setup Location Manager
    ///      This function setup location manager to get live user location
    fileprivate func setupLocationManager() {
        locationManagerDelegate.CheckLocationPermission()
        locationManagerDelegate.didUpdateLocationsAction = { [weak self] location in
            self?.viewModel.updateUserLocation(with: location)
        }
        print("✅ MapView : setup Location Manager completed.")
    }
    
    
    // MARK: Setup Map View
    ///     This function Setup Base MapView Setting
    fileprivate func setupMapView() {
        
        // Creating a VectorElementLayer (called routeShapeLayer) to add Route Shape and adding it to map's layers
        // Route Shape Will add to this Vector Element Layer when user select start finding route
        routeShapeLayer = NTNeshanServices.createVectorElementLayer()
        mapView.getLayers()?.add(routeShapeLayer)
        
        // Creating a VectorElementLayer (called destinationMarkerLayer)
        // Marker Will add to this Vector Element Layer when user select location to route
        destinationMarkerLayer = NTNeshanServices.createVectorElementLayer()
        mapView.getLayers()?.add(destinationMarkerLayer)
        
        // Creating a VectorElementLayer(called userMarkerLayer) to add user marker to it and adding it to map's layers
        // Marker Will add to this Vector Element Layer when user select device live location
        userLocationMarkerLayer = NTNeshanServices.createVectorElementLayer()
        mapView.getLayers()?.add(userLocationMarkerLayer)
        
        // add STANDARD_DAY map to layer BASE_MAP_INDEX
        mapView.getOptions()?.setZoom(NTRange(min: 4.5, max: 24))
        let baseMap: NTLayer = NTNeshanServices.createBaseMap(NTNeshanMapStyle.STANDARD_DAY)
        mapView.getLayers()?.insert(BASE_MAP_INDEX, layer: baseMap)
        mapView.getLayers()?.insert(TRAFFIC_INDEX, layer: NTNeshanServices.createTrafficLayer())
        
        // Setting map focal positionto a fixed position and setting camera zoom
        mapView.setFocalPointPosition(NTLngLat(x: 59.5985341783917, y: 36.26763274005621), durationSeconds: 0.5)
        mapView.setZoom(17, durationSeconds: 0.5)
        
        print("✅ MapView : setup MapView completed.")
    }
    
    
    // MARK: Setup Map event Observer
    ///     This function Add Event Listener To Map For Get User Selected Location
    fileprivate func setupMapEventListener(){
        let mapEventListener = MapEventListener()
        mapEventListener?.onMapClickedBlock =  { [weak self] clickInfo in
            if clickInfo.getClickType() == NTClickType.CLICK_TYPE_LONG {
                // by calling getClickPos(), we can get position of clicking (or tapping)
                let clickedLocation = clickInfo.getClickPos()
                
                // MARK: Update Selected location
                self?.viewModel.userSelectLocation(at: clickedLocation!)
            }
        }
        mapView.setMapEventListener(mapEventListener)
        print("✅ MapView : setup Map Observer completed.")
    }
    
    // MARK: Setup Billboard View
    fileprivate func setupBillboardView() {
        
        let router = BillboardRouter(viewModel: viewModel)
        router.billboardView = billboardContainerView
        router.view = view
        router.ExitTapped = { [weak self] in
            self?.cleanMapViewLayers()
        }
        let vc : BillboardView = BillboardView(delegate: router)
        
        viewModel.billboardRouter = router
        viewModel.billboardDelegate = vc
        
        addVCToContainer(vc: vc, to: billboardContainerView)
        print("✅ MapView : setup Billboard View completed.")
    }
    
    // MARK: Setup Search view
    fileprivate func setupSearchView() {
        
        let router = SearchRouter(viewModel: viewModel)
        router.searchView = searchContainerView
        router.view = view
        
        let vc : SearchView = SearchView(delegate: router)
        viewModel.searchRouter = router
        
        addVCToContainer(vc: vc, to: searchContainerView)
        
        print("✅ MapView : setup Search View completed.")
    }
    
}
