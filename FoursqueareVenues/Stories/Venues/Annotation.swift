//
//  Annotation.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/3/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    let title: String?
    let venueId: String
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(venue: Venue) {
        
        self.title = venue.name
        self.venueId = venue.id
        self.locationName = venue.location.formattedAddress[0]
        self.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
