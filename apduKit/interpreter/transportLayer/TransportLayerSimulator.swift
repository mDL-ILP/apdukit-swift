//
//  TransportLayerSimulator.swift
//  apduKit
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

class TransportLayerSimulator: TransportLayer {
    var delegate: TransportLayerDelegate?
    var externalMockTransportLayer: TransportLayer?
    
    func connect(transportLayer: TransportLayer) {
        self.externalMockTransportLayer = transportLayer
    }
    
    func write(data: [byte]) throws {
        guard let transportLayer = self.externalMockTransportLayer else {
            throw InterpeterErrors.SocketException()
        }
        try transportLayer.onReceive(data: data)
    }
    
    func close() throws {
        self.externalMockTransportLayer = nil
    }
    
    func set(delegate: TransportLayerDelegate) {
        self.delegate = delegate
    }
    
    func onReceive(data: [byte]) throws {
        guard let delegate = self.delegate else {
            throw InterpeterErrors.SocketException()
        }
        try delegate.onReceive(data: data)
    }
    
}
