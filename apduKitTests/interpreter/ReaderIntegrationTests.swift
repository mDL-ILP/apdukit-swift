//
//  ReaderIntegrationTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import XCTest

public class ReaderIntegrationTests: IntegrationTests {
    public func testDisconnected() throws {
        try self.readerTransportLayer.close()
        let p = self.reader.read(file: ExampleApp.instance.ValidEF_NoShortId)
        
        XCTAssertThrowsError(try p.getValue())
    }
}
