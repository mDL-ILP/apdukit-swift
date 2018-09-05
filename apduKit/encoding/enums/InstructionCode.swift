//
//  InstructionCode.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * Instruction code - indicates the specific command, e.g. "select file"
 *
 */
enum InstructionCode: byte {
    case SELECT = 0xA4
    case READ_BINARY = 0xB0
    
    //Returns a InstructionCode for raw value byte.
    static func valueOf(byte value: byte?) -> InstructionCode? {
        guard let value = value else { return nil }
        return InstructionCode.init(rawValue: value)
    }
    
    func getValue() -> byte {
        return self.rawValue
    }
}
