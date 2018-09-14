//
//  PromiseTest.swift
//  apduKitTests
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest
import Promises

class PromiseTest: XCTestCase {
    func testGetValueFulfill() throws {
        let expectation = self.expectation(description: "Catch called")
        let test = Promise<Bool>(on: DispatchQueue.apduPromises) { () -> Bool in
            usleep(3000)
            return true
        }
        test.then { (res) in
            expectation.fulfill()
        }
        let result = try test.getValue()
        XCTAssertEqual(true, result)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetValueReject() throws {
        enum testError: Error {
            case Example(description: String)
        }
        let test = Promise<Bool>(on: DispatchQueue.apduPromises) { () -> Bool in
            usleep(3000)
            throw testError.Example(description: "example")
        }
        XCTAssertThrowsError(try test.getValue())
    }
}
