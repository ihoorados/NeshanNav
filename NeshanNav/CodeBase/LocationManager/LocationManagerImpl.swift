//
//  LocationManager.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
import CoreLocation

class LocationManagerImpl:NSObject, CLLocationManagerDelegate,LocationManager{
    
    // MARK: Call Back Action
    var didUpdateLocations:((_ location:CLLocation)->Void)?
    
    //MARK: Location Manager
    private var locationManager: CLLocationManager
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func StartUpdatingUserLocation(){
        locationManager.startUpdatingLocation()
    }
    
    func StopUpdatingUserLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    func CheckLocationPermission(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("🔴 MapView: No access To Location Service")
                    requestWhenInUseAuthorization()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("🟢 MapView: Access To Location Service.")
                @unknown default:
                break
            }
        } else {
                print("🔵 MapView: Location services are not enabled")
                requestWhenInUseAuthorization()
        }
    }
    
    private func requestWhenInUseAuthorization(){
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Delegate Fail With erro : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        didUpdateLocations?(location)
    }
}
