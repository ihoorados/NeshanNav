//
//  MapViewModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//


import Foundation
import CoreLocation


// MARK: Map View Model Class
class MapViewViewModel{
    
    // MARK: Properties
    var userLocation:       NTLngLat = NTLngLat(x: 59.59853417839179, y: 36.26763274005621)
    var selectedLocation:   NTLngLat?
    var routesLocations:    [NTLngLat] = [NTLngLat]()

    // MARK: Delegate Dependency
    weak var mapViewDelegate:       MapViewDelegate?
    weak var billboardDelegate:     BillboardDelegate?

    // MARK: Repository Dependency
    private let routesRepo:    MapRoutesRepository
    private let locationRepo:  LocationInfoRepository
    private let routeDistanceRepo:  DistanceMatrixRepository
    
    // Billboard Router
    var billboardRouter:BillboardRouter?
    // Search Router
    var searchRouter:SearchRouter?
    
    // MARK: init
    init(routeInfoRepo: MapRoutesRepository = MapRoutesRepositoryImp(),
         locationInfoRepo: LocationInfoRepository = LocationInfoRepositoryImp(),
         distanceRepo:DistanceMatrixRepository = DistanceMatrixRepositoryImp()) {
        routesRepo = routeInfoRepo
        locationRepo = locationInfoRepo
        routeDistanceRepo = distanceRepo
    }
    
    func requestForLocationInfo(with location:Location){
        billboardDelegate?.isLoading(loading: true)
        locationRepo.getLocationInfoOverNetwork(at: location) { [weak self] result in
            self?.billboardDelegate?.isLoading(loading: false)
            switch result{
                case .success(let data):
                    self?.billboardDelegate?.updateViewDataModel(with: data)
                    self?.billboardRouter?.CTATapped = { [weak self] in
                        self?.startFindingRoute()
                    }
                case.failure(_):
                    self?.billboardDelegate?.updateViewDataWithError()
                    self?.billboardRouter?.CTATapped = { [weak self] in
                        self?.requestForLocationInfo(with: location)
                    }
            }
        }
    }
    
    func requestForRoutes(from:NTLngLat,to:NTLngLat){
        billboardDelegate?.isLoading(loading: true)
        routesRepo.getRouteInfoOverNetwork(pointA: from, PointB: to) { [weak self] result in
            switch result {
                case .success(let routes):
                    self?.showRouteShape(routes: routes)
                case .failure(_):
                    self?.billboardDelegate?.updateViewDataWithError()
                    self?.billboardRouter?.CTATapped = { [weak self] in
                        self?.requestForRoutes(from: from,to: to)
                    }
            }
        }
    }
    
    func requestForDistance(from:NTLngLat,to:NTLngLat){
        billboardDelegate?.isLoading(loading: true)
        routeDistanceRepo.getDistanceMatrixOverNetwork(pointA: from, PointB: to) { [weak self] result in
            self?.billboardDelegate?.isLoading(loading: false)
            switch result {
                case .success(let distance):
                    guard let element = distance.rows.first?.elements.first else {
                        self?.billboardDelegate?.updateViewDataWithError()
                        self?.billboardRouter?.CTATapped = { [weak self] in
                            self?.requestForDistance(from: from,to: to)
                        }
                        return
                    }
                    self?.billboardDelegate?.updateViewDataModel(with: element)
                    self?.billboardRouter?.CTATapped = { [weak self]  in
                        self?.startNavigateOnRoutes()
                    }
                case .failure(_):
                    self?.billboardDelegate?.updateViewDataWithError()
                    self?.billboardRouter?.CTATapped = { [weak self] in
                        self?.requestForDistance(from: from,to: to)
                    }
            }
        }
    }
    
    
    private func showRouteShape(routes:Routes){
        
        // Create New Route Locations
        routesLocations.removeAll()
        
        let locations = getLocationsForrouteShape(for: routes)
        routesLocations.append(contentsOf: locations)
        // Draw Route Shape On Map View
        mapViewDelegate?.addRouteShape(locs: routesLocations)
    }

}


// MARK: Decode encoded String To CLLocationCoordinate2D
extension MapViewViewModel{
    
    // MARK: Helper
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }

    // MARK: Decode encoded string polyline
    ///   This Function Decode encoded string polyline and return route locations
    ///
    /// - returns: Array of CLLocationCoordinate2D
    func polyLineWithEncodedString(encodedString: String) -> [CLLocationCoordinate2D] {
        var myRoutePoints=[CLLocationCoordinate2D]()
        let bytes = (encodedString as NSString).utf8String
        var idx: Int = 0
        var latitude: Double = 0
        var longitude: Double = 0
        while (idx < encodedString.lengthOfBytes(using: String.Encoding.utf8)) {
            var byte = 0
            var res = 0
            var shift = 0
            repeat {
                byte = Int(bytes![idx] - 63)
                idx += 1
                res |= (byte & 0x1F) << shift
                shift += 5
            } while (byte >= 0x20)
            let deltaLat = ((res & 1) != 0x0 ? ~(res >> 1) : (res >> 1))
            latitude += Double(deltaLat)

            shift = 0
            res = 0
            repeat {
                byte = Int(bytes![idx] - 63)
                idx += 1
                res |= (byte & 0x1F) << shift
                shift += 5
            } while (byte >= 0x20)
            let deltaLon = ((res & 1) != 0x0 ? ~(res >> 1) : (res >> 1))
            longitude += Double(deltaLon)

            myRoutePoints.append(CLLocation(latitude: Double(latitude * 1E-5), longitude: Double(longitude * 1E-5)).coordinate)
        }
        return myRoutePoints
    }
    
    func getLocationsForrouteShape(for route:Routes) -> [NTLngLat] {
        var locations:[NTLngLat] = [NTLngLat]()
        for route in route.routes{
            for leg in route.legs{
                for step in leg.steps{
                    
                    let polyLine = self.polyLineWithEncodedString(encodedString: step.polyline)
                    
                    for loc in polyLine{
                        locations.append(NTLngLat(x: loc.longitude, y: loc.latitude))
                    }
                }
            }
        }
        return locations
    }
    
    func getLocationsForMockNavigate(locations:[NTLngLat]) -> [NTLngLat] {
        var locationsArray = [NTLngLat]()
        locationsArray.removeAll()
        for i in 0...locations.count - 1{
            if i+1 > locations.count - 1{
                break
            }
            let loc1 = CLLocation(latitude: locations[i].getY(), longitude: locations[i].getX())
            let loc2 = CLLocation(latitude: locations[i+1].getY(), longitude: locations[i+1].getX())
            
            let distance = loc1.distance(from: loc2)
            
            if Int(distance) > 1 {
                
                let midArr = geographicMidpoints(startPoint: loc1.coordinate,
                                                 endPoint: loc2.coordinate, total: distance)
                for loc in midArr {
                    locationsArray.append(NTLngLat(x: loc.longitude, y: loc.latitude))
                }
                
            }
        }
        return locationsArray
    }
    
    //       /** Degrees to Radian **/
    ///       This Function Add Points between Tow Location Coordinate
    private func geographicMidpoints(startPoint: CLLocationCoordinate2D,endPoint:CLLocationCoordinate2D,total:Double) -> [CLLocationCoordinate2D] {
        let yourTotalCoordinates = total //1 number of coordinates, change it as per your uses
        let latitudeDiff = startPoint.latitude - endPoint.latitude
        let longitudeDiff = startPoint.longitude - endPoint.longitude
        let latMultiplier = latitudeDiff / (yourTotalCoordinates + 1)
        let longMultiplier = longitudeDiff / (yourTotalCoordinates + 1)
        var array = [CLLocationCoordinate2D]() //6
        for index in 1...Int(yourTotalCoordinates) { //7
            let lat  = startPoint.latitude - (latMultiplier * Double(index))
            let long = startPoint.longitude - (longMultiplier * Double(index))
            let point = CLLocationCoordinate2D(latitude: lat, longitude: long)
            array.append(point) //11
        }
        return array
    }
    

}
