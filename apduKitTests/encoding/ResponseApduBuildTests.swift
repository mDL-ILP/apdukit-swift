//
//  ResponseApduBuildTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

class ResponseApduBuildTests: XCTestCase {
    var subject: ResponseApdu!
    
    override func setUp() {
        self.subject = ResponseApdu()
    }
    
    func testSuccessfulProcessing() {
        //Setup
        let expected: [byte] = [0x90, 0x00]
        subject.statusCode = .SUCCESSFUL_PROCESSING
        
        //Call
        let result = try? subject.toBytes().buffer
        
        XCTAssertEqual(expected, result)
    }
    
    func testSuccessfulProcessingWithData() {
        //Setup
        let data: [byte] = [0x71, 0x82, 0x01, 0x05, 0x80, 0x01]
        let expected = data + [0x90, 0x00]
        subject.data = data
        subject.statusCode = .SUCCESSFUL_PROCESSING
        
        //Call
        let result = try? subject.toBytes().buffer
        
        XCTAssertEqual(expected, result)
    }
}

