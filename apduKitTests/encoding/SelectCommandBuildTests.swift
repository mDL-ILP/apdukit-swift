//
//  SelectCommandTests.swift
//  apduKitTests
//  All the build tests to go from an object to bytes.
//  Created by Iain Munro on 29/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

class SelectCommandBuildTests: XCTestCase {
    
    var subject: SelectCommand!
    
    override func setUp() {
        self.subject = SelectCommand()
    }
    
    func testSelectDF() {
        //Setup
        subject.fileID = ExampleApp.instance.ValidDF_NormalLength2
        subject.expectedResult = ExpectedResultType.NOTHING
        let expected: [byte] = [0x0, 0xA4, 0x04, 0x0C, 0x07, 0xA0, 0x00, 0x00, 0x02, 0x48, 0x04, 0x00]
        //Call
        let result = try? subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(expected, result!)
    }
    
    func testSelectExtendedDF() {
        //Setup
        subject.fileID = ExampleApp.instance.ValidDF_ExtendedLength
        subject.expectedResult = ExpectedResultType.NOTHING
        let expected: [byte] = [0x0, 0xA4, 0x04, 0x0C, 0x00, 0x01, 0x05] + ExampleApp.instance.ValidDF_ExtendedLength.getValue()!
        //Call
        let result = try? subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(expected, result!)
    }
    
    func testSelectEF() {
        //Setup
        subject.fileID = ExampleApp.instance.ValidEF_NoShortId
        subject.expectedResult = ExpectedResultType.NOTHING
        let expected: [byte] = [0x00, 0xA4, 0x02, 0x0C, 0x02, 0x01, 0x1C]
        //Call
        let result = try? subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(expected, result!)
    }
    
    func testValidation() {
        callValidation(expected: "fileID")
        subject.fileID = ExampleApp.instance.ValidEF1
        callValidation(expected: "expectedResult")
        subject.expectedResult = .NOTHING
        try! subject.validate()
    }
    
    private func callValidation(expected: String) {
        do {
            try self.subject.validate()
            XCTFail("It should've thrown an exception")
        } catch ApduErrors.ValueNotSetException(let value) {
            XCTAssertEqual(expected, value)
        } catch {
            XCTFail("It threw the wrong exception")
        }
    }
}
