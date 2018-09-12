//
//  ConversionUtilsTest.swift
//  apduKitTests
//
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

class ConversionUtilsTests: XCTestCase {
    func testBackAndForth8BitChanging() {
        let from = byte(0x1E)
        let to = byte(0x9E)
        XCTAssertEqual(from, ConversionUtils.replaceBit8with0(to))
        XCTAssertEqual(to, ConversionUtils.replaceBit8with1(from))
    }
    
    func testBytesToShort() {
        let input = [byte(0x01), byte(0x05)]
        let expected = short(261)
        XCTAssertEqual(expected, try ConversionUtils.fromBytesToShort(input))
    }
    
    func testBytesToShort2() {
        let input = [byte(7)]
        let expected = short(7)
        XCTAssertEqual(expected, try ConversionUtils.fromBytesToShort(input))
    }
    
    func testBytesToShort3() {
        let input = [byte(0x00), byte(0xff)]
        let expected = short(255)
        XCTAssertEqual(expected, try ConversionUtils.fromBytesToShort(input))
    }
    
    func testBytesToShort4() {
        let input = [byte(0x00), byte(0xff), byte(0xff)]
        XCTAssertNil(try? ConversionUtils.fromBytesToShort(input))
    }
    
    func testShortToBytes() {
        let input = short(0x9000)
        let expected: [byte] = [0x90, 0x00]
        XCTAssertEqual(expected, ConversionUtils.fromShortToBytes(input))
    }
    
    func testByteToBits() {
        var input = byte(1)
        var result = ConversionUtils.byteToBits(byte: input)
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0, 1], result)
        
        input = byte(2)
        result = ConversionUtils.byteToBits(byte: input)
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 1, 0], result)
        
    }
    
    func testBytesToBits() {
        var input: [byte] = [1]
        var result = ConversionUtils.bytesToBits(bytes: input)
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0, 1], result)
        
        input = [1, 3]
        result = ConversionUtils.bytesToBits(bytes: input)
        XCTAssertEqual([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1], result)
    }
}
