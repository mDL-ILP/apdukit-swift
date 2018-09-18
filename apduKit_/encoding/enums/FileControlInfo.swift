//
//  ExpectedResultType.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * FileControlInfo - the file control information (FCI) is the string of data bytes available in response to a SELECT FILE command. #5.1.5 File control information
 * English: Indicates what kind of data we want returned in the ResponseApdu after a command
 */
internal enum FileControlInfo: byte {
    /// Return no file control info.
    case NOFCIReturn = 0x0C
    
    //Returns a SelectCommandExpected for raw value byte.
    static func valueOf(code value: byte?) -> FileControlInfo? {
        guard let value = value else { return nil }
        return FileControlInfo.init(rawValue: value)
    }
    
    func getValue() -> byte {
        return self.rawValue
    }
}
