//
//  HolderIntegrationTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 14/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest
import Promises
import Cuckoo

internal class HolderIntegrationTests: IntegrationTests {

    internal func testInvalidOnReceive() throws {
        //Mock transport layer so it doesn't actually write.
        let transportLayer = MockTransportLayerSimulator().withEnabledSuperclassSpy()
        self.holderTransportLayer = transportLayer
        setupSessionLayers()

        stub(transportLayer) { (transportLayerStub) in
            when(transportLayerStub.write(data: any())).thenDoNothing()

            //Then call the onReceive function with an invalid apdu.
            holderSessionLayer.onReceive(data: [0, 0, 1])

            //Verify that it sent back a reply saying: Error unknown.
            verify(transportLayer, atLeastOnce()).write(data: any())
        }
    }
    
}
