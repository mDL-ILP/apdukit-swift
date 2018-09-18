//
//  FileType.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * FileType - indicates what kind type of file it should expect.
 *
 */
internal enum FileType: byte {
    //Dedicated file
    case DF = 0x04
    //Elementary file
    case EF = 0x02
    
    //Returns a FileType for raw value byte.
    static func valueOf(code value: byte?) -> FileType? {
        guard let value = value else { return nil }
        return FileType.init(rawValue: value)
    }
    
    func getValue() -> byte {
        return self.rawValue
    }
}
