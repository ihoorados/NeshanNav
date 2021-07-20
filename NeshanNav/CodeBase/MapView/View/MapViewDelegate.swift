//
//  MapViewDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
import CoreLocation

protocol MapViewDelegate: AnyObject {
    func addUserLiveLocationMarker(loc: NTLngLat)
    func addSelectedLocationMarker(loc: NTLngLat)
    func startMockNavigation(on locs: [NTLngLat])
    func cameraRouteToLocation(loc:NTLngLat)
    func addRouteShape(locs: [NTLngLat])
    func cleanMapViewLayers()
}

extension MapView: MapViewDelegate{

    // MARK: Route Camera To Location
    func cameraRouteToLocation(loc: NTLngLat) {
        DispatchQueue.main.async {
            self.mapView.setFocalPointPosition(loc, durationSeconds: 0.3)
        }
    }

    // MARK: Add Route shape To MapView
    func addRouteShape(locs: [NTLngLat]) {
        
        // Clear Previous route Shape Layer
        routeShapeLayer.clear()
        
        // Create Vector For Lat & Long
        let lngLatVector = NTLngLatVector()
        for loc in locs{
            lngLatVector?.add(loc)
        }
        
        // Create line
        let lineGeom = NTLineGeom(poses: lngLatVector)
        let line = NTLine(geometry: lineGeom, style: getLineStyle())
        
        // Move Camera To route bound
        DispatchQueue.main.async {
            
            // Add All Line in NTVectorElementLayer
            self.routeShapeLayer.add(line)
            
            //
            let scale: CGFloat = UIScreen.main.scale
            let viewportBounds = NTViewportBounds(min: NTViewportPosition(x: 0, y: 0), max: NTViewportPosition(x: Float(self.mapView.frame.size.width * scale), y: Float((self.mapView.frame.size.height - self.billboardContainerView.frame.height) * scale)))
            let bounds = line?.getBounds()
            self.mapView.move(toCameraBounds: bounds, viewportBounds: viewportBounds, integerZoom: true, durationSeconds: 0.9)
        }
        print("🟢 MapViewDelegate: Route Shape Add To MapView")
    }
    
    // MARK: Live Location Marker
    func addUserLiveLocationMarker(loc: NTLngLat) {
        
        // Clearing userMarkerLayer
        userLocationMarkerLayer.clear()
        
        let animStB1 = NTAnimationStyleBuilder()!
        animStB1.setFade(NTAnimationType.ANIMATION_TYPE_SMOOTHSTEP)
        animStB1.setSizeAnimationType(NTAnimationType.ANIMATION_TYPE_SPRING)
        animStB1.setPhaseInDuration(0.3)
        animStB1.setPhaseOutDuration(0.3)
        let animSt = animStB1.buildStyle()
        // Creating marker style.
        let markStCr = NTMarkerStyleCreator()
        markStCr?.setAnimationStyle(animSt)
        markStCr?.setSize(20)
        let image = UIImage(systemName: "largecircle.fill.circle")?.withTintColor(.systemBlue)
        markStCr?.setBitmap(NTBitmapUtils.createBitmap(from: image))
        let markSt: NTMarkerStyle = markStCr!.buildStyle()
        // Creating user marker
        userLocationMarker = NTMarker(pos: loc, style: markSt)
        // Adding user marker to userMarkerLayer, or showing marker on map!
        DispatchQueue.main.async {
            self.userLocationMarkerLayer.add(self.userLocationMarker)
        }
        print("🟢 MapViewDelegate: User Location Marker Add To MapView")
    }

    
    // MARK: - Add Marker
    ///        This function gets a LngLat as input and adds a marker on that position
    func addSelectedLocationMarker(loc: NTLngLat) {
        // Clear Previous route Shape Layer
        routeShapeLayer.clear()
        // Clear Previuose Marker
        destinationMarkerLayer.clear()
        
        // Creating animation for marker (NTMarkerStyle)
        let markStyle = createNTMarker()
        // Creating marker
        let marker = NTMarker(pos: loc, style: markStyle)
        // Adding marker to markerLayer, or showing marker on map!
        DispatchQueue.main.async {
            self.destinationMarkerLayer.add(marker)
        }
        print("🟢 MapViewDelegate: Selected Location Marker Add To MapView")
    }
    
    // MARK: MapView Close Billboard
    func cleanMapViewLayers(){
        DispatchQueue.main.async {
            self.routeShapeLayer.clear()
            self.destinationMarkerLayer.clear()
            self.mapView.setTilt(90, durationSeconds: 0)
            self.mapView.setZoom(17, durationSeconds: 0.5)
            self.timer?.invalidate()
        }
        print("🟢 MapViewDelegate: Close Billboard")
    }
    
    // MARK: MapView Start Mock Navigation
    /// This Function start mock navigate on mapView
    func startMockNavigation(on locs: [NTLngLat]){
        var locations = locs
        mapView.setTilt(40, durationSeconds: 0.5)
        mapView.setZoom(19.0, durationSeconds: 0.5)
        cameraRouteToLocation(loc: locations.first!)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] timer in
                if locations.count > 1 {
                    
                    let loc1 = CLLocation(latitude: locations[0].getY(), longitude: locations[0].getX())
                    let loc2 = CLLocation(latitude: locations[1].getY(), longitude: locations[1].getX())
                    
                    let bearing = self?.viewModel.getBearingBetweenTwoPoints1(point1: loc1, point2: loc2)

                    self?.mapView.setBearing(Float(bearing!), durationSeconds: 0.0)
                                        
                    let location = locations.removeFirst()
                    self?.mapView.setFocalPointPosition(location, durationSeconds: 0.0)
                    self?.userLocationMarker.setPos(location)
                }else{
                    self?.timer?.invalidate()
                }
            }
        }
    }
    
    
    /// This Function Call When Need To User Selected Marker
    ///
    /// - returns: Marker Style of type NTMarkerStyle
    private func createNTMarker() -> NTMarkerStyle{
        // Creating animation for marker. We should use an object of type AnimationStyleBuilder, set
        // all animation features on it and then call buildStyle() method that returns an object of type
        // AnimationStyle
        let animStB1 = NTAnimationStyleBuilder()
        animStB1?.setFade(NTAnimationType.ANIMATION_TYPE_SMOOTHSTEP)
        animStB1?.setSizeAnimationType(NTAnimationType.ANIMATION_TYPE_SPRING)
        animStB1?.setPhaseInDuration(0.5)
        animStB1?.setPhaseOutDuration(0.5)
        let animSt = animStB1!.buildStyle()
        // Creating marker style. We should use an object of type MarkerStyleCreator, set all features on it
        // and then call buildStyle method on it. This method returns an object of type MarkerStyle
        let markStCr = NTMarkerStyleCreator()
        markStCr?.setSize(30)
        markStCr?.setBitmap(NTBitmapUtils.createBitmap(from: UIImage(named: "RouteMarker")))
        // AnimationStyle object - that was created before - is used here
        markStCr?.setAnimationStyle(animSt)
        var markSt = NTMarkerStyle()
        markSt = markStCr!.buildStyle()
        return markSt
    }
    
    /// This Function Call When Need To Route Shape Line
    ///
    /// - returns: Line Style of type NTLineStyle
    private func getLineStyle() -> NTLineStyle {
        let lineStCr = NTLineStyleCreator()
        lineStCr?.setColor(NTARGB(r: UInt8(2), g: UInt8(119), b: UInt8(200), a: UInt8(250)))
        lineStCr?.setWidth(10)
        lineStCr?.setStretchFactor(30)
        return (lineStCr?.buildStyle())!
    }

}
