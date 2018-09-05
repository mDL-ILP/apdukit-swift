//
//  ExpectedResultType.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * ExpectedResultType - indicates what kind of data we want returned in the ResponseApdu after a select command.
 *
 */
enum ExpectedResultType: byte {
    //NOFCIReturn: Return no file control info.
    case NOTHING = 0x0C
    
    //Returns a SelectCommandExpected for raw value byte.
    static func valueOf(code value: byte?) -> ExpectedResultType? {
        guard let value = value else { return nil }
        return ExpectedResultType.init(rawValue: value)
    }
    
    func getValue() -> byte {
        return self.rawValue
    }
}
