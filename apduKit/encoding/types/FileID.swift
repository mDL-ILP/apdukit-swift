//
//  FileID.swift
//  apduKit
//  File identifier for apdu files determining datagroups
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
public protocol FileID {
    func getValue() -> [byte]?
}
