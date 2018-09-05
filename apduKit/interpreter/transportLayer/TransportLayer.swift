//
//  TransportLayer.swift
//  apduKit
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

protocol TransportLayer {
    func write(data: [byte]) throws
    func close() throws
    func set(delegate: TransportLayerDelegate)
    func onReceive(data: [byte]) throws
}
