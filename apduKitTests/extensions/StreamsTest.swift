//
//  InputStreamTest.swift
//  apduKitTests
//  TODO: Replace our own stream implementation with an existing solution.
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

class StreamsTest: XCTestCase {
    func testOutputStream() {
        let outputStream = ByteArrayOutputStream()
        outputStream.write(byte: byte(0x01))
        outputStream.write(byte: byte(0x11))
        XCTAssertEqual([byte(0x01), byte(0x011)], outputStream.buffer)
    }
    
    func testInputStream() {
        let input: [byte] = [0x12, 0x33, 0x67]
        let inputStream = ByteArrayInputStream(bytes: input)
        XCTAssertEqual(input.count, inputStream.available())
        
        XCTAssertEqual(input[0], inputStream.readByte())
        XCTAssertEqual(input.count-1, inputStream.available())
        
        XCTAssertEqual(input[1], inputStream.readByte())
        XCTAssertEqual(input.count-2, inputStream.available())
        
        XCTAssertEqual(input[2], inputStream.readByte())
        XCTAssertEqual(input.count-3, inputStream.available())
        
        XCTAssertEqual(0, inputStream.available())
        XCTAssertEqual(nil, inputStream.readByte())
        XCTAssertEqual(0, inputStream.available())
    }
    
    //Read several bytes at once.
    func testInputStreamBytes() {
        let input: [byte] = [0x12, 0x33, 0x67]
        let inputStream = ByteArrayInputStream(bytes: input)
        XCTAssertEqual([0x12, 0x33], try inputStream.readBytes(size: 2))
        XCTAssertEqual(1, inputStream.available())
    }
    
}
