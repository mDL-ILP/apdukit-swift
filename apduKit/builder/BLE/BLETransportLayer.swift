//
//  BLETransportLayer.swift
//  apduKit
//
//  Created by Iain Munro on 17/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 BLECentralTransportLayer - Central's transport layer. It is initialized using a connected peripheral it found beforehand.
**/
class BLETransportLayer: BluetoothDeviceDelegate, TransportLayer {
    var peer: BluetoothDevice
    var delegate: TransportLayerDelegate?
    
    init(peer: BluetoothDevice) {
        self.peer = peer
    }
    
    
    func received(_ remotePeer: BluetoothDevice, data: Data) {
        self.delegate?.onReceive(data: [UInt8](data))
    }
    
    func write(data: [byte]) throws {
        self.peer.sendData(Data(bytes: data)) { (data, peer, err) in
            //TODO: Tell the delegate things went south.
        }
    }
    
    func close() throws {
//        self.peer.
    }
    
    func set(delegate: TransportLayerDelegate) {
        self.delegate = delegate
    }
    
}
