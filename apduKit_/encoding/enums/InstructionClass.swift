//
//  InstructionClass.swift
//  apduKit
//
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * Instruction class - indicates the type of command, e.g. inter industry or proprietary
 *
 */
enum InstructionClass: byte {
    case DEFAULT = 0x00
    case SECURE_MESSAGING = 0x0C
    
    //Returns a InstructionCode for raw value byte.
    static func valueOf(byte value: byte?) -> InstructionClass? {
        guard let value = value else { return nil }
        return InstructionClass.init(rawValue: value)
    }
    
    func getValue() -> byte {
        return self.rawValue
    }
}
