//
//  TransportLayerSimulator.swift
//  apduKit
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public class TransportLayerSimulator: TransportLayer {
    var delegate: TransportLayerDelegate?
    var externalMockTransportLayer: TransportLayerSimulator?
    
    func connect(transportLayer: TransportLayerSimulator) {
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
    
    public func onReceive(data: [byte]) throws {
        guard let delegate = self.delegate else {
            throw InterpeterErrors.SocketException()
        }
        delegate.onReceive(data: data)
    }
    
}
