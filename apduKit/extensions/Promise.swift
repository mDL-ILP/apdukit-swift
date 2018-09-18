//
//  Promise.swift
//  apduKit
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

extension Promise {
    internal func getValue() throws -> Value {
        return try await(self)
    }
}

extension DispatchQueue {
    static var apduPromises = DispatchQueue.global(qos: .background)
}
