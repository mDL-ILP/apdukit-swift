//
//  Apdu.swift
//  apduKit
//
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
/**
 * Application Protocol Data Unit base type. Upon both requests and responses types are built.
 */
protocol Apdu {
    /**
    * Validate Apdu. Each type will throw if values aren't set etc.
    */
    func validate() throws
    
    /**
    * Apdu to bytes.
    */
    func toBytes() throws -> ByteArrayOutputStream
}
