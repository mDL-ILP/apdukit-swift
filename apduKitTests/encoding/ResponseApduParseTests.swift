//
//  ResponseApduParseTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

class ResponseApduParseTests: XCTestCase {
    
    func testSuccessfulProcessing() throws {
        //Setup
        let stream = ByteArrayInputStream(bytes: [0x90, 0x00])
        //Call
        let result = try? ResponseApdu(stream: stream)
        
        XCTAssertEqual(nil, result?.data)
        XCTAssertEqual(StatusCode.SUCCESSFUL_PROCESSING, result?.statusCode)
        
    }
    
    func testSuccessfulProcessingWithData() {
        //Setup
        let data: [byte] = [0x71, 0x82, 0x01, 0x05, 0x80, 0x01]
        let stream = ByteArrayInputStream(bytes: data + [0x90, 0x00])
        //Call
        let result = try? ResponseApdu(stream: stream)
        
        XCTAssertEqual(data, result?.data)
        XCTAssertEqual(StatusCode.SUCCESSFUL_PROCESSING, result?.statusCode)
    }
}
