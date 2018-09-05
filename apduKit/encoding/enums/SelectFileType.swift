//
//  SelectFileType.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * SelectFileType - indicates what kind type of file it should expect.
 *
 */
enum SelectFileType: byte {
    //Dedicated file
    case DF = 0x04
    //Elementary file
    case EF = 0x02
    
    //Returns a SelectCommandExpected for raw value byte.
    static func valueOf(code value: byte?) -> SelectFileType? {
        guard let value = value else { return nil }
        return SelectFileType.init(rawValue: value)
    }
    
    func getValue() -> byte {
        return self.rawValue
    }
}
