//
//  TransportLayerBuilder.swift
//  apduKit
//
//  Created by Iain Munro on 17/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

/**
 A TransportLayerBuilder will build a transport layer given search parameters.
 */
public protocol TransportLayerBuilder {
    func build() -> Promise<TransportLayer>
}
