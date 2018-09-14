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

public class HolderIntegrationTests: IntegrationTests {

    public func testInvalidOnReceive() throws {
        //Mock transport layer so it doesn't actually write.
        let transportLayer = MockTransportLayerSimulator().withEnabledSuperclassSpy()
        self.readerTransportLayer = transportLayer
        setupSessionLayers()

        let reader = MockReaderApplicationLayer(presentationLayer: self.readerPresentationLayer, appId: ExampleApp.instance.ValidDF_NormalLength2).withEnabledSuperclassSpy()
        self.reader = reader
        self.readerPresentationLayer.set(delegate: self.reader)

        stub(reader) { (readerStub) in
            stub(transportLayer) { (transportLayerStub) in

                when(readerStub.onReceiveInvalidApdu(exception: any())).thenDoNothing()

                //Then call the onReceive function with an invalid apdu.
                readerSessionLayer.onReceive(data: [0, 0, 1])

                //Verify that the error was reported all the way back to the application
                verify(reader, atLeastOnce()).onReceiveInvalidApdu(exception: any())
            }
        }
    }
    
}
