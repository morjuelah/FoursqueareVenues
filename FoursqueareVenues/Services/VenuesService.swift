//
//  VenuesService.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import Foundation

class VenuesService {
    
    let baseService = BaseService()
    
    func getMainLocalization(completion: @escaping (GeoCode) -> Void, error: @escaping () -> Void) {
       
        baseService.callVenuesService(completion: { [weak self] (venuesResponse) in
            
            guard let strongSelf = self else { return }
            
            if let mainLocalization = strongSelf.parseMainLocalization(venuesResponse) {
                completion(mainLocalization)
            } else {
                error()
            }
        }) {
            error()
        }
    }
    
    func getVenues(completion: @escaping ([Venue]) -> Void, error: @escaping () -> Void) {
        
        baseService.callVenuesService(completion: { [weak self] (venuesResponse) in
            
            guard let strongSelf = self else { return }
            
            if let venues = strongSelf.parseVenues(venuesResponse) {
                completion(venues)
            } else {
                error()
            }
        }) {
            error()
        }
    }
    
    private func parseMainLocalization(_ venuesResponse: [String:Any]) -> GeoCode? {
        
        guard let responseData = venuesResponse["response"] as? [String: Any],
            let geoCode = responseData["geocode"] as? [String: Any] else { return nil }
        
        do {
            let geoCodeData = try JSONSerialization.data(withJSONObject: geoCode)
            let mainLocalization = try JSONDecoder().decode(GeoCode.self, from: geoCodeData)
            
            return mainLocalization
        } catch {
            return nil
        }
    }
    
    private func parseVenues(_ venuesResponse: [String:Any]) -> [Venue]? {
        
        guard let response = venuesResponse["response"] as? [String: Any],
            let groups = response["groups"] as? [[String: Any]] else { return nil }
        
        var venues: [Venue] = []
        
        for group in groups {
            
            if let items = group["items"] as? [[String: Any]] {
            
                for item in items {
                    
                    if let venueJson = item["venue"] as? [String: Any] {
                    
                        do {
                            let venueData = try JSONSerialization.data(withJSONObject: venueJson)
                            let venue = try JSONDecoder().decode(Venue.self, from: venueData)
                            
                            venues.append(venue)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        
        return venues
    }
}
