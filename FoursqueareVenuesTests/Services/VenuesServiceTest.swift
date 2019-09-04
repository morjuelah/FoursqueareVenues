//
//  VenuesServiceTest.swift
//  FoursqueareVenuesTests
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import XCTest
@testable import FoursqueareVenues

class VenuesServiceTest: XCTestCase {

    let service = VenuesService()
    let timeout = 5.0
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetMainLocalization() {
        
        let serviceExpectation = self.expectation(description: "\(String(describing: self)) expectation")
        
        service.getMainLocalization(completion: { (geoCode) in
            
            print(geoCode)
            
            serviceExpectation.fulfill()
        }, error: {
          
            serviceExpectation.fulfill()
            XCTFail("Error")
        })
        
        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }
    
    func testGetVenues() {
        
        let serviceExpectation = self.expectation(description: "\(String(describing: self)) expectation")
        
        service.getVenues(completion: { (venues) in
            
            print(venues.count)
            
            serviceExpectation.fulfill()
        }, error: {
            
            serviceExpectation.fulfill()
            XCTFail("Error")
        })
        
        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }
}
