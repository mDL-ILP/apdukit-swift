//
//  ReadBinaryOffsetCommandParseTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

class ReadBinaryOffsetCommandParseTests: XCTestCase {
    func testReadBinaryOffsetCommandSimple() {
        //Setup
        let input: [byte] = [0, 0xB0, 0, 40, 7]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is ReadBinaryOffsetCommand)
        let result = command as? ReadBinaryOffsetCommand
        
        XCTAssertEqual(40, result?.offset)
        XCTAssertEqual(7, result?.maximumExpectedLength)
    }
    
    func testReadBinaryOffsetCommandExtendedLength() {
        //Setup
        let input: [byte] = [0, 0xB0, 0x00, 33, 0x00, 0x01, 0x05]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is ReadBinaryOffsetCommand)
        let result = command as? ReadBinaryOffsetCommand
        
        XCTAssertEqual(33, result?.offset)
        XCTAssertEqual(261, result?.maximumExpectedLength)
    }
    
    func testInvalidReadBinaryOffset() {
        //Setup
        let input: [byte] = [0, 0xB0, 0x00, 0x00]
        //Call
        XCTAssertThrowsError(try CommandApdu.fromBytes(input))
    }
    
    func testZeroMeansExtendedLength() {
        //Setup
        let input: [byte] = [0, 0xB0, 0x00, 0x00, 0x00, 0x00]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is ReadBinaryOffsetCommand)
        let result = command as? ReadBinaryOffsetCommand
        XCTAssertEqual(Constants.EXTENDED_LENGTH, result?.maximumExpectedLength);
    }
    
}
