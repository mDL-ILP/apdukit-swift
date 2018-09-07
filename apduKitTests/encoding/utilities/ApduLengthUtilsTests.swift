//
//  ApduLengthUtilsUnitTest.swift
//  apduKitTests
//
//  Created by Iain Munro on 28/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

import XCTest

//Normal means not extended length
class ApduLengthUtilsUnitTests: XCTestCase {
    func testEncodeDataLengthExtended() {
        let length = short(261)//Value higher than 255
        let result = ApduLengthUtils.encodeDataLength(length: length)
        XCTAssertEqual(3, result.count, "Value is higher than 255. So length is represented in 3 bytes")
        XCTAssertEqual(0, result[0], "First byte should be 0 to indicate that its extended length")
        XCTAssertEqual([0x0, 0x01, 0x05], result)
    }
    
    func testEncodeDataLengthNormal() {
        let length = short(5)//Value lower than 255
        let result = ApduLengthUtils.encodeDataLength(length: length)
        XCTAssertEqual(1, result.count, "Value is lower than 255. So length is represented in 1 byte")
        XCTAssertEqual(0x05, result[0], "First byte should be the length given")
    }
    
    func testDecodeDataLengthNormal() {
        let stream = ByteArrayInputStream(bytes: [7, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(7, try ApduLengthUtils.decodeDataLength(stream: stream))
    }
    
    func testDecodeDataLengthNormalFailure() {
        var data = Array<byte>.init(repeating: 0, count: 600)
        data[0] = 1
        data[1] = 0x02
        let stream = ByteArrayInputStream(bytes: data)
        XCTAssertThrowsError(try ApduLengthUtils.decodeDataLength(stream: stream))
    }
    
    func testDecodeDataLength_NoData() {
        XCTAssertThrowsError(try ApduLengthUtils.decodeDataLength(stream: ByteArrayInputStream(bytes: [])))
    }
    
    func testDecodeDataLengthExtendedSuccess() {
        var data = Array<byte>.init(repeating: 0, count: 263)
        data[0] = 0
        data[1] = 0x01
        data[2] = 0x04
        let stream = ByteArrayInputStream(bytes: data)
        XCTAssertEqual(260, try ApduLengthUtils.decodeDataLength(stream: stream))
    }
    
    func testDecodeDataLengthExtendedFailure() {
        var data = Array<byte>.init(repeating: 0, count: 263)//More than 2.
        data[0] = 0
        data[1] = 0x00
        data[2] = 0xFF
        let stream = ByteArrayInputStream(bytes: data)
        XCTAssertThrowsError(try ApduLengthUtils.decodeDataLength(stream: stream))
    }
    
    func testDecodeMaxExpectedLengthNormal() {
        let stream = ByteArrayInputStream(bytes: [0x05])
        XCTAssertEqual(5, try ApduLengthUtils.decodeMaxExpectedLength(stream: stream))
    }
    
    func testDecodeMaxExpectedLengthExtended() {
        let stream = ByteArrayInputStream(bytes: [0x00])
        XCTAssertEqual(256, try ApduLengthUtils.decodeMaxExpectedLength(stream: stream))
    }
    
    func testDecodeMaxExpectedLengthExtended2() {
        let stream = ByteArrayInputStream(bytes: [0x00, 0x00])
        XCTAssertEqual(Constants.DEFAULT_MAX_EXPECTED_LENGTH_EXTENDED, try ApduLengthUtils.decodeMaxExpectedLength(stream: stream))
    }
    
    func testDecodeMaxExpectedLengthExtended3() {
        let stream = ByteArrayInputStream(bytes: [0x00, 0x01, 0x02])
        XCTAssertEqual(258, try ApduLengthUtils.decodeMaxExpectedLength(stream: stream))
    }
    
    func testDecodeMaxExpectedLengthExtendedFailure() {
        let stream = ByteArrayInputStream(bytes: [0x01, 0x05])
        XCTAssertThrowsError(try ApduLengthUtils.decodeMaxExpectedLength(stream: stream))
    }
    
    func testDecodeMaxExpectedLengthExtendedFailure2() {
        let stream = ByteArrayInputStream(bytes: [0x00, 0x01])
        XCTAssertThrowsError(try ApduLengthUtils.decodeMaxExpectedLength(stream: stream))
    }
    
    func testEncodeMaxExpectedLengthExtended_EdgeCase() throws {
        let value = try ApduLengthUtils.encodeMaxExpectedLength(length: Constants.DEFAULT_MAX_EXPECTED_LENGTH_EXTENDED)
        XCTAssertEqual([0x00, 0x00], value)
    }
    
    func testInvalidMaxExpectedLengthEncoding() {
        XCTAssertThrowsError(try ApduLengthUtils.encodeMaxExpectedLength(length: 65537))
    }
    
}
