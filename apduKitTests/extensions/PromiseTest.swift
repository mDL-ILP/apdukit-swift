//
//  PromiseTest.swift
//  apduKitTests
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest
import Promise

class PromiseTest: XCTestCase {
    func testGetFileFulfill() throws {
        let test = Promise<Bool>(work: { (fulfill, reject) in
            usleep(3000)
            fulfill(true)
        })
        test.then { (res) in
            print("test")
        }
        let result = try test.getValue()
        XCTAssertEqual(true, result)
    }
    
    func testGetFileReject() throws {
        enum testError: Error {
            case Example(description: String)
        }
        
        let test = Promise<Bool>(work: { (fulfill, reject) in
            usleep(3000)
            reject(testError.Example(description: "example"))
        })
        XCTAssertThrowsError(try test.getValue())
    }
    
    func testEasyThen() throws {
        let a = Promise<[byte]> { (fulfill, reject) in
            let payload: [byte] = [0, 1, 2, 3]
            fulfill(payload)
        }
        a.then { (result) in
            print(result)
        }
        try a.getValue()
    }
}
