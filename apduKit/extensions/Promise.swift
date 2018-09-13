//
//  Promise.swift
//  apduKit
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promise

extension Promise {
    public func getValue() throws -> Value {
        let lock = DispatchSemaphore(value: 1)
        self.always(on: DispatchQueue.global()) {
            lock.signal()
        }
        lock.wait()
        lock.wait()
        lock.signal()
        if let e = self.error {
            throw e
        }
        return self.value!
    }
}
