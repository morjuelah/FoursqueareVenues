//
//  BaseService.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
    
    func callVenuesService(completion: @escaping ([String: Any]) -> Void, error: @escaping () -> Void) {
        
        let venuesUrl = "https://api.foursquare.com/v2/venues/explore?client_id=THIZC0VI0JOVPHJJJW1JIJNX5HWCTP1DCMQ1RJFE22IFL0OX&client_secret=VBYPUXJL044KXSUY2RYYRAVY4DRKJR4XFL3AKMD5VB1EYSJQ&v=20180405&near=New York"
        
        guard let encodedUrl = venuesUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        Alamofire.request(encodedUrl).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                if let value = response.result.value, let json = value as? [String: Any] {
                    
                    completion(json)
                } else {
                    
                    error()
                }
            } else {
                if let error = response.result.error {
                    print(error)
                }
                error()
            }
        }
    }
}
