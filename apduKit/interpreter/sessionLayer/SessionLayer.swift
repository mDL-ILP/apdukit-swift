//
//  SessionLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

/**
 * The session layer handles sending and receiving apdu messages. It decodes incoming bytes into Apdu objects and then calls the appropriate delegate message handle method.
 * It also allows for sending apdu commands and keeping track of this open request. Then fufilling the promise upon receiving data.
 */
internal protocol SessionLayer: TransportLayerDelegate {
    func send(command: CommandApdu) -> Promise<ResponseApdu>
    func set(delegate: SessionLayerDelegate)
}
