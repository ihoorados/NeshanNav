//
//  DistanceMatrixModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

// MARK: - DistanceMatrixModel
struct DistanceMatrixModel: Codable {
    let status: String
    let rows: [Row]
    let origin_addresses, destination_addresses: [String]
}

// MARK: - Row
struct Row: Codable {
    let elements: [Element]
}

// MARK: - Element
struct Element: Codable {
    let status: String
    let duration, distance: Distance
}
