//
//  InternalAuthenticateCommandBuildTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 07/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

class InternalAuthenticateCommandBuildTests: XCTestCase {
    
    var subject: InternalAuthenticateCommand!
    
    override func setUp() {
        super.setUp()
        self.subject = InternalAuthenticateCommand()
    }
    
    func testInternalAuthenticateDefaultMaxExpLength() {
        //Setup
        subject.algorithmInfo = Constants.DEFAULT_ALGORITHM_INFO
        subject.referenceDataQualifier = Constants.DEFAULT_REFERENCE_DATA_QUALIFIER
        subject.challenge = [0,0,0,0,0,0,0,0]
        
        //Call
        let result = try! subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(0x0, result[0], "InstructionClass")
        XCTAssertEqual(0x88, result[1], "InstructionCode")
        XCTAssertEqual(Constants.DEFAULT_ALGORITHM_INFO, result[2], "algorithmInfo")
        XCTAssertEqual(Constants.DEFAULT_REFERENCE_DATA_QUALIFIER, result[3], "referenceDataQualifier")
        XCTAssertEqual(0x08, result[4], "le")
        XCTAssertEqual(0x00, result[5], "data")
        XCTAssertEqual(0x00, result[6], "data")
        XCTAssertEqual(0x00, result[7], "data")
        XCTAssertEqual(0x00, result[8], "data")
        XCTAssertEqual(0x00, result[9], "data")
        XCTAssertEqual(0x00, result[10], "data")
        XCTAssertEqual(0x00, result[11], "data")
        XCTAssertEqual(0x00, result[12], "data")
        XCTAssertEqual(0x00, result[13], "data")
        XCTAssertEqual(0x00, result[14], "data")
    }
    
    func testValidation() {
        callValidation(expected: "Invalid challenge")
        subject.challenge = [0,0,0,0,0,0,0,0]
        callValidation(expected: "algorithmInfo")
        subject.algorithmInfo = Constants.DEFAULT_ALGORITHM_INFO
        callValidation(expected: "referenceDataQualifier")
        subject.referenceDataQualifier = Constants.DEFAULT_REFERENCE_DATA_QUALIFIER
        try! subject.validate()
    }

    private func callValidation(expected: String) {
        do {
            try self.subject.validate()
            XCTFail("It should've thrown an exception")
        } catch ApduErrors.InvalidApduException(let description) {
            XCTAssertEqual(expected, description)
        } catch ApduErrors.ValueNotSetException(let value) {
            XCTAssertEqual(expected, value)
        } catch {
            XCTFail("It threw the wrong exception")
        }
    }
    
}
