//
//  BaseServiceTest.swift
//  FoursqueareVenuesTests
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import XCTest
@testable import FoursqueareVenues

class BaseServiceTest: XCTestCase {
    
    let service = BaseService()
    let timeout = 5.0
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testVenuesService() {
     
        let serviceExpectation = self.expectation(description: "\(String(describing: self)) expectation")
        
        service.callVenuesService(completion: { (json) in
            print(json)
            
            serviceExpectation.fulfill()
        }) {
            serviceExpectation.fulfill()
            XCTFail("Error")
        }
        
        self.waitForExpectations(timeout: self.timeout, handler: nil)
    }
}
