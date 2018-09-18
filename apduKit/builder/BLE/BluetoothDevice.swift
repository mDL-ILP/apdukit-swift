//
//  Peer.swift
//  apduKit
//
//  Created by Iain Munro on 18/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import BluetoothKit_fork

//To simplify the whole central, peripheral thing.
open class BluetoothDevice: BKRemotePeerDelegate {
    public let peer: BKPeer//Us. Self. This can be a central or peripheral. its the object we use to send our data.
    public let remotePeer: BKRemotePeer
    public let delegate: BluetoothDeviceDelegate? = nil
    
    init(peer: BKPeer, remotePeer: BKRemotePeer) {
        self.peer = peer
        self.remotePeer = remotePeer
        self.remotePeer.delegate = self
    }
    
    open func sendData(_ data: Data, completionHandler: BKSendDataCompletionHandler?) {
        self.peer.sendData(data, toRemotePeer: self.remotePeer, completionHandler: completionHandler)
    }
    
    public func remotePeer(_ remotePeer: BKRemotePeer, didSendArbitraryData data: Data) {
        print("received data.... \(data)")
        self.delegate?.received(self, data: data)
    }
    
}
