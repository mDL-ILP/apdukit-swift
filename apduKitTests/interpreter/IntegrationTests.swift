//
//  IntegrationTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest

public class IntegrationTests: XCTestCase {
    
    public var holderTransportLayer: TransportLayerSimulator!
    public var readerTransportLayer: TransportLayerSimulator!
    public var holderSessionLayer: SessionLayer!
    public var readerSessionLayer: SessionLayer!
    public var holderPresentationLayer: PresentationLayer!
    public var readerPresentationLayer: PresentationLayer!
    
    public var holder: TestHolder!
    public var reader: TestReader!
    
    public override func setUp() {
        setupTransportLayers()
    }
    
    func setupTransportLayers() {
        holderTransportLayer = TransportLayerSimulator()
        readerTransportLayer = TransportLayerSimulator()
        holderTransportLayer.connect(transportLayer: readerTransportLayer)
        readerTransportLayer.connect(transportLayer: holderTransportLayer)
        
        setupSessionLayers()
    }
    
    func setupSessionLayers() {
        holderSessionLayer = HolderSessionLayer(transportLayer: holderTransportLayer)
        readerSessionLayer = ReaderSessionLayer(transportLayer: readerTransportLayer)
        setupPresentationLayers()
    }
    
    func setupPresentationLayers() {
        holderPresentationLayer = ApduProtocolPresentationLayer(sessionLayer: holderSessionLayer)
        readerPresentationLayer = ApduProtocolPresentationLayer(sessionLayer: readerSessionLayer)
        setupApplicationLayers()
    }
    
    func setupApplicationLayers() {
        self.holder = TestHolder(presentationLayer: holderPresentationLayer)
        self.reader = TestReader(presentationLayer: readerPresentationLayer)
    }
    
}
