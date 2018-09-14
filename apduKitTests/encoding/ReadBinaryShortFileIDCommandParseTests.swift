//
//  ReadBinaryShortFileIDCommandParseTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

class ReadBinaryShortFileIDCommandParseTests: XCTestCase {
    func testReadBinaryOffsetCommandSimple() {
        //Setup
        let input: [byte] = [0, 0xB0, 0x83, 40, 7]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is ReadBinaryShortFileIDCommand)
        let result = command as? ReadBinaryShortFileIDCommand
        
        XCTAssertEqual(try ExampleApp.instance.ValidEF2.getShortIdentifier(), try result?.elementaryFileID?.getShortIdentifier())
        XCTAssertEqual(40, result?.offset)
        XCTAssertEqual(7, result?.maximumExpectedLength)
    }
    
    func testReadBinaryOffsetCommandExtendedMaxExpectedLength() {
        //Setup
        let input: [byte] = [0, 0xB0, 0x81, 40, 0x00, 0x01, 0x03]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is ReadBinaryShortFileIDCommand)
        let result = command as? ReadBinaryShortFileIDCommand
        
        XCTAssertEqual(try ExampleApp.instance.ValidShortIdEF1.getShortIdentifier(), try result?.elementaryFileID?.getShortIdentifier())
        XCTAssertEqual(40, result?.offset)
        XCTAssertEqual(259, result?.maximumExpectedLength)
    }
    
}
