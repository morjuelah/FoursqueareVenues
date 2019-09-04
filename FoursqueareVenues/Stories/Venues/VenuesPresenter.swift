//
//  VenuesPresenter.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/3/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class VenuesPresenter {
    
    var mapViewController: MapViewController?
    
    var venues: [Venue] = []
    var venuesAnnotations: [Annotation] = []
    
    var initialLocation: CLLocation?
    let regionRadius: CLLocationDistance = 5000
    var currentRegion: MKCoordinateRegion?
    
    let venuesService = VenuesService()
    
    func getVenues(completion: @escaping () -> Void) {
        
        venuesService.getVenues(completion: { [weak self] (venues) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.venues = venues
            strongSelf.createVenuesAnnotations()
            strongSelf.updateDistanceFromInitialLocationToVenues()
            completion()
        }) { [weak self] in
            
            self?.venues = []
            print("Error getting venues")
            completion()
        }
    }
    
    func getInitialLocalization() {
        
        venuesService.getMainLocalization(completion: { [weak self] (localization) in
            
            guard let strongSelf = self else { return }
            
            strongSelf.initialLocation = CLLocation(latitude: localization.center.lat, longitude: localization.center.lng)
            strongSelf.centerMapOnLocation(location: strongSelf.initialLocation)
            strongSelf.updateDistanceFromInitialLocationToVenues()
        }) {
            print("Error getting initial location")
        }
    }
    
    func centerMapOnLocation(location: CLLocation?) {
        guard let location = location else { return }
        
        currentRegion = MKCoordinateRegion(center: location.coordinate,
                                           latitudinalMeters: regionRadius,
                                           longitudinalMeters: regionRadius)
        
        mapViewController?.centerMap()
    }
    
    private func createVenuesAnnotations() {
        
        for venue in venues {
            
            let annotation = Annotation(venue: venue)
            venuesAnnotations.append(annotation)
        }
        
        mapViewController?.showVenues()
    }
    
    func selectVenue(_ venue: Venue) {
        
        if let selectedAnnotation = venuesAnnotations.first(where: {$0.venueId == venue.id}) {
            
            let annotationLocation = CLLocation(latitude: selectedAnnotation.coordinate.latitude, longitude: selectedAnnotation.coordinate.longitude)
            
            centerMapOnLocation(location: annotationLocation)
            mapViewController?.showSelectedAnnotation(selectedAnnotation)
        }
    }
    
    private func updateDistanceFromInitialLocationToVenues() {
        guard !venues.isEmpty else { return }
        
        for i in 0...venues.count - 1 {
            
            if let initialCoordinate = initialLocation {
                
                let finalCoordinate = CLLocation(latitude: venues[i].location.lat, longitude: venues[i].location.lng)
                
                let distance = initialCoordinate.distance(from: finalCoordinate)
                
                let newVenue = Venue(id: venues[i].id,
                                     name: venues[i].name,
                                     location: venues[i].location,
                                     categories: venues[i].categories,
                                     distanceFromOrigin: distance / 1000)
                
                venues[i] = newVenue
            }
        }
    }
}
