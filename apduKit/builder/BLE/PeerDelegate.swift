//
//  PeerDelegate.swift
//  apduKit
//
//  Created by Iain Munro on 18/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public protocol BluetoothDeviceDelegate {
    func received(_ remotePeer: BluetoothDevice, data: Data)
}
