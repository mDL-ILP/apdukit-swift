//
//  BLETransportLayerBuilderDelegate.swift
//  apduKit
//
//  Created by Iain Munro on 17/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public protocol TransportLayerBuilderDelegate {
    func onChanged(state: TransportLayerBuilderState)
}
