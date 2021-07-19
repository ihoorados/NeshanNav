//
//  MapViewModelDelegate.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
import CoreLocation

//MARK: Map View Model Delegate
protocol mapViewModelDelegate: AnyObject {
    
    func updateUserLocation(with location: CLLocation)
    func userSelectLocation(at location: NTLngLat)
    func cameraMoveToUserLocation()
    func startNavigateOnRoutes()
    func startFindingRoute()
    func cleanMapViewLayer()
    func getBearingBetweenTwoPoints1(point1: CLLocation, point2: CLLocation) -> Double

    var billboardDelegate:BillboardDelegate? { get set }
    var mapViewDelegate:MapViewDelegate? { get set }
    
    var billboardRouter: BillboardRouter?  { get set }
    var searchRouter: SearchRouter? { get set }
    
    var userLocation: NTLngLat { get set }

}

// MARK: Map View Model Delegate IMP
extension MapViewViewModel: mapViewModelDelegate{
    
    
    func cleanMapViewLayer() {
        mapViewDelegate?.cleanMapViewLayers()
    }
    
    func cameraMoveToUserLocation() {
        mapViewDelegate?.cameraRouteToLocation(loc: userLocation)
        mapViewDelegate?.addUserLiveLocationMarker(loc: userLocation)
    }
    
    func updateUserLocation(with location:CLLocation){
//        IF You Want Update Current User Device Location uncomment Below Lines
        
//        let x = location.coordinate.latitude
//        let y = location.coordinate.longitude
//        userLocation = NTLngLat(x: x,y: y)
//        mapViewDelegate?.cameraRouteToLocation(location: userLocation)
//        mapViewDelegate?.addUserLiveLocationMarker(userLocation)
    }
    
    func userSelectLocation(at location:NTLngLat){
        selectedLocation = location
        mapViewDelegate?.addSelectedLocationMarker(loc: location)
        mapViewDelegate?.cameraRouteToLocation(loc: location)
        requestForLocationInfo(with: Location(latitude: location.getY(), longitude: location.getX()))
    }
    
    func startNavigateOnRoutes() {
        let locations = getLocationsForMockNavigate(locations: routesLocations)
        mapViewDelegate?.startMockNavigation(on: locations)
        billboardDelegate?.updateViewToNavigateState()
    }
    
    func startFindingRoute() {
        guard let location = selectedLocation else {
            return
        }
        mapViewDelegate?.addUserLiveLocationMarker(loc: userLocation)
        requestForRoutes(from: userLocation, to: location)
        requestForDistance(from: userLocation, to: location)
    }
    

    func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {

        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)

        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
                
        let radiansBearing = atan2(y, x)
        var degrees = radiansToDegrees(radians: radiansBearing)
        degrees = (360 - ((degrees + 360).truncatingRemainder(dividingBy: 360)))
        return degrees
    }
    
    
}

