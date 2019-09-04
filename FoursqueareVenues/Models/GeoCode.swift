//
//  GeoCode.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import Foundation

struct GeoCodeLocation: Codable {
    var lat: Double
    var lng: Double
}

struct GeoCode: Codable {
    var center: GeoCodeLocation
    var displayString: String
    var `where`: String
}
