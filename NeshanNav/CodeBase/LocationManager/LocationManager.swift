//
//  LocationManager.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/22/21.
//

import Foundation
import CoreLocation

protocol LocationManager: AnyObject {
    func StartUpdatingUserLocation()
    func StopUpdatingUserLocation()
    func CheckLocationPermission()
    var  didUpdateLocations: ((_ location: CLLocation) -> Void)?  { get set }
}
