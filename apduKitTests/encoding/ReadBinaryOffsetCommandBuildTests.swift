//
//  ReadBinaryOffsetCommandTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

class ReadBinaryOffsetCommandBuildTests: XCTestCase {
    
    var subject: ReadBinaryOffsetCommand!
    
    override func setUp() {
        super.setUp()
        self.subject = ReadBinaryOffsetCommand()
    }
    
    func testOffsetBelow255() {
        //Setup
        _ = subject.set(offset: 40)
        _ = subject.set(maximumExpectedLength: 6)
        
        //Call
        let result = try! subject.toBytes().buffer

        //Assertion
        XCTAssertEqual(byte(0x0), result[0], "InstructionClass")
        XCTAssertEqual(0xB0, result[1], "InstructionCode")
        XCTAssertEqual(0x0, result[2], "most significant byte")
        XCTAssertEqual(0x28, result[3], "least significant byte")
        XCTAssertEqual(0x06, result[4], "le")
    }
    
    func testOffsetAbove255() {
        //Setup
        _ = subject.set(offset: 270)//Above 255
        _ = subject.set(maximumExpectedLength: 123)
        
        //Call
        let result = try! subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(byte(0x0), result[0], "InstructionClass")
        XCTAssertEqual(0xB0, result[1], "InstructionCode")
        XCTAssertEqual(0x01, result[2], "most significant byte")
        XCTAssertEqual(0x0E, result[3], "least significant byte")
        XCTAssertEqual(123, result[4], "le")
    }
    
    func testExtendedMaxExpLength() {
        //Setup
        _ = subject.set(offset: 1)//Above 255
        _ = subject.set(maximumExpectedLength: 261)//Above 255
        
        //Call
        let result = try! subject.toBytes().buffer
        
        //Assertion
        XCTAssertEqual(byte(0x0), result[0], "InstructionClass")
        XCTAssertEqual(0xB0, result[1], "InstructionCode")
        XCTAssertEqual(0x0, result[2], "most significant byte")
        XCTAssertEqual(0x01, result[3], "least significant byte")
        XCTAssertEqual(0, result[4], "length")
        XCTAssertEqual(1, result[5], "length")
        XCTAssertEqual(5, result[6], "length")
    }
    
}
