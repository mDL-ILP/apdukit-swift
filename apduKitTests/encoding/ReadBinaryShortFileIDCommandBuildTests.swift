//
//  ReadBinaryShortFileIDCommandBuildTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

class ReadBinaryShortFileIDCommandBuildTests: XCTestCase {
    
    var subject: ReadBinaryShortFileIDCommand!
    
    override func setUp() {
        super.setUp()
        self.subject = ReadBinaryShortFileIDCommand()
    }
    
    func testOffsetBelow255() {
        //Setup
        subject.elementaryFileID = ExampleApp.instance.ValidEF2
        subject.offset = byte(40)
        subject.maximumExpectedLength = int(7)
        
        //Call
        let result = try! subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(0x0, result[0], "InstructionClass")
        XCTAssertEqual(0xB0, result[1], "InstructionCode")
        XCTAssertEqual(0x83, result[2], "short file identifier")
        XCTAssertEqual(0x28, result[3], "offset")
        XCTAssertEqual(0x07, result[4], "le")
    }
    
    func testOffsetAbove255() {
        //Setup
        subject.elementaryFileID = ExampleApp.instance.ValidEF2
        subject.offset = byte(0x01)
        subject.maximumExpectedLength = int(261)//Above 255
        
        //Call
        let result = try! subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(0x0, result[0], "InstructionClass")
        XCTAssertEqual(0xB0, result[1], "InstructionCode")
        XCTAssertEqual(0x83, result[2], "short file identifier")
        XCTAssertEqual(0x01, result[3], "offset")
        XCTAssertEqual(0x0, result[4], "le_1")
        XCTAssertEqual(0x01, result[5], "le_1")
        XCTAssertEqual(0x05, result[6], "le_1")
    }
    
    func testCalidation() {
        callValidation(expected: "elementaryFileID")
        subject.elementaryFileID = ExampleApp.instance.ValidEF1
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
