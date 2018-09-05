//
//  SelectCommandParseTests.swift
//  apduKitTests
//  All the parse tests to go from an bytes to an object.
//  Created by Iain Munro on 29/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

class SelectCommandParseTests: XCTestCase {
    func testSelectDFSuccess() {
        //Setup
        let input: [byte] = [0x0, 0xA4, 0x04, 0x0C, 0x07, 0xA0, 0x00, 0x00, 0x02, 0x48, 0x04, 0x00]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is SelectCommand)
        let result = command as? SelectCommand
        
        XCTAssertEqual(SelectFileType.DF, result?.fileType)
        XCTAssertEqual(ExpectedResultType.NOTHING, result?.expectedResult)
        XCTAssertEqual(ExampleApp.instance.ValidDF_NormalLength2.getValue(), result?.fileID?.getValue())
    }
    
    func testSelectDFExtendedSuccess() {
        //Setup
        let input: [byte] = [0x0, 0xA4, 0x04, 0x0C, 0x00, 0x01, 0x05] + ExampleApp.instance.ValidDF_ExtendedLength.getValue()!
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is SelectCommand)
        let result = command as? SelectCommand
        
        XCTAssertEqual(SelectFileType.DF, result?.fileType)
        XCTAssertEqual(ExpectedResultType.NOTHING, result?.expectedResult)
        XCTAssertEqual(ExampleApp.instance.ValidDF_ExtendedLength.getValue(), result?.fileID?.getValue())
    }
    
    func testSelectEFSuccess() {
        //Setup
        let input: [byte] = [0x00, 0xA4, 0x02, 0x0C, 0x02, 0x01, 0x1C]
        //Call
        let command = try? CommandApdu.fromBytes(input)
        XCTAssertTrue(command is SelectCommand)
        let result = command as? SelectCommand
        
        XCTAssertEqual(SelectFileType.EF, result?.fileType)
        XCTAssertEqual(ExpectedResultType.NOTHING, result?.expectedResult)
        XCTAssertEqual(ExampleApp.instance.ValidEF_NoShortId.getValue(), result?.fileID?.getValue())
    }
}
