//
//  TransportLayerSimulatorUnitTest.swift
//  apduKitTests
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest
import Cuckoo

class TransportLayerSimulatorTests: XCTestCase {
    var subject1: TransportLayerSimulator!
    var subject2: MockTransportLayerSimulator!
    
    override func setUp() {
        self.subject1 = TransportLayerSimulator()
        self.subject2 = MockTransportLayerSimulator()
    }
    
    func testWrite() throws {
        let payload:[byte] = [0, 1, 2, 3]
        subject1.connect(transportLayer: subject2)
        
        stub(self.subject2) { stub in
            when(stub.onReceive(data: any())).thenDoNothing()
            try! subject1.write(data: payload)
            verify(self.subject2, atLeastOnce()).onReceive(data: any())
        }
    }
    
    func testDisconnectedWrite() throws {
        XCTAssertThrowsError(try subject1.write(data: []))
    }
    
    func testOnReceive() throws {
        let transportDelegate = MockTransportLayerDelegate()
        subject1.set(delegate: transportDelegate)
        stub(transportDelegate) { stub in
            when(stub).onReceive(data: any()).thenDoNothing()
            try! subject1.onReceive(data: [0, 1, 2])
            verify(transportDelegate, atLeastOnce()).onReceive(data: any())
        }
    }
    
    func testDisconnectedOnReceive() throws {
        XCTAssertThrowsError(try subject1.onReceive(data: []))
    }
    
    func testClose() throws {
        subject1.connect(transportLayer: subject2)
        try subject1.close()
        XCTAssertThrowsError(try subject1.onReceive(data: []))
    }
    
}
