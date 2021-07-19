//
//  SearchModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

// MARK: - RouteInfo
struct SearchLocationModel: Codable {
    let count: Int
    let items: [SearchItem]
}

// MARK: - Item
struct SearchItem: Codable {
    let title, address, neighbourhood, region: String?
    let type, category: String
    let location: Locations
}

// MARK: - Location
struct Locations: Codable {
    let x, y: Double
    let z: String?
}
