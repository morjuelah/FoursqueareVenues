//
//  Venue.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import Foundation

struct Venue: Codable {
    var id: String
    var name: String
    var location: VenueLocation
    var categories: [Category]
    var distanceFromOrigin: Double?
}

struct VenueLocation: Codable {
    var lat: Double
    var lng: Double
    var formattedAddress: [String]
}

struct Category: Codable {
    var id: String
    var name: String
    var icon: CategoryIcon
}

struct CategoryIcon: Codable {
    var prefix: String
    var suffix: String
    
    var url: String {
        get {
            return self.prefix + "bg_64" + self.suffix
        }
    }
}
