//
//  interpreterErrors.swift
//  apduKit
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

enum InterpeterErrors: Error {
    case SocketException()
    case OutOfSequenceException()
}
