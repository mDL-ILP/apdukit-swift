//
//  ElementaryFileIDTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 07/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

class ElementaryFileIDTests: XCTestCase {
    func testValidShortId() throws {
        _ = try ElementaryFileID(shortIdentifier: 0x01)
    }
    
    func testInvalidShortFileID() throws {
        XCTAssertThrowsError(try ElementaryFileID(shortIdentifier: 0x8E))
    }

}
