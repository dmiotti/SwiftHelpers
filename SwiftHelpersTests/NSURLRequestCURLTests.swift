//
//  NSURLRequestCURLTests.swift
//  SwiftHelpers
//
//  Created by David Miotti on 11/01/16.
//  Copyright © 2016 Wopata. All rights reserved.
//

import XCTest
import SwiftHelpers

class NSURLRequestCURLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testcURL() {
        let req = NSMutableURLRequest(URL: NSURL(string: "http://google.fr")!)
        req.HTTPMethod = "POST"
        let params = [ "email": "david.miotti@wopata.com", "password": "atapow" ]
        let json = try! NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        req.HTTPBody = json
        req.setValue("Boddy", forHTTPHeaderField: "Authorization")
        
        let cURL = req.cURL()

        let rangeOfMethod = cURL.rangeString("-X POST")
        XCTAssert(rangeOfMethod.length > 0, "Should have a -X POST")
        
        let rangeOfHeader = cURL.rangeString("-H 'Authorization: Boddy'")
        XCTAssert(rangeOfHeader.length > 0, "Should have formatted header")
        
        let rangeOfParams = cURL.rangeString("-d '{\"email\":\"david.miotti@wopata.com\",\"password\":\"atapow\"}'")
        XCTAssert(rangeOfParams.length > 0, "Should have formatted params")
        
        let rangeOfURL = cURL.rangeString("'http://google.fr'")
        XCTAssert(rangeOfURL.length > 0, "Should have URL in it")
    }
    
}