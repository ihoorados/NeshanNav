//
//  MapViewModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//


import Foundation
import CoreLocation

//MARK: Map View Model Delegate
protocol MapViewViewModel: AnyObject {
    
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
