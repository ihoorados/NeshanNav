//
//  RoutesModel.swift
//  NeshanNav
//
//  Created by Hoorad Ramezani on 7/19/21.
//

import Foundation

// MARK: - Routes
struct Routes:Codable {
    let routes: [Route]
}

// MARK: - Route
struct Route: Codable {
    let overview_polyline: OverviewPolyline
    let legs: [Leg]
}

// MARK: - Leg
struct Leg: Codable {
    let summary: String
    let distance, duration: Distance
    let steps: [Step]
}

// MARK: - Distance
struct Distance: Codable {
    let value: Int
    let text: String
}

// MARK: - Step
struct Step: Codable {
    let name, instruction: String
    let distance, duration: Distance
    let polyline, maneuver: String
    let start_location: [Double]
}

// MARK: - OverviewPolyline
struct OverviewPolyline: Codable {
    let points: String
}

/* --------------------------------------------------------------- */

// MARK: - RouteModel
struct RouteModel:Codable {
    let status, neighbourhood, municipality_zone, state: String?
    let city: String?
    let in_odd_even_zone: Bool?
    let route_name, route_type, formatted_address: String?
}

let MockRouteInformationModel = RouteModel(status: "Ok", neighbourhood: "تهران، فاطمي، حجاب، سازمان آب",
                                           municipality_zone: "سازمان آب",
                                           state: "secondary",
                                           city: "فاطمي", in_odd_even_zone: false,
                                           route_name: "تهران",
                                           route_type: "تهران",
                                           formatted_address: "6")

/* --------------------------------------------------------------- */

// MARK: - SnappedPoint
struct SnappedPoint {
    let location: Location
    let originalIndex: Int
}

// MARK: - Location
struct Location {
    let latitude, longitude: Double
}


/* Mock Model For This Request
   URL : https://api.neshan.org/v1/map-matching?path=36.552884,53.076659%7c36.556222,53.078948
   Start Point : 36.552884,53.076659
   End Point   : 36.556222,53.078948 */
let mockSnappedPoint = [SnappedPoint(location: Location(latitude: 36.552874, longitude: 53.076616), originalIndex: 0),
                        SnappedPoint(location: Location(latitude: 36.556211, longitude: 53.078939), originalIndex: 1)]
