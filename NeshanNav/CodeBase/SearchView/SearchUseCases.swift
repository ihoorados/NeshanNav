//
//  SearchUseCases.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation
protocol SearchUseCases: AnyObject {
    func cameraMoveToUserLocation()
    func userSelectAddress(location:NTLngLat)
    func searchViewHeightChangetTo(height: CGFloat)
    func userLocation() -> NTLngLat
}
