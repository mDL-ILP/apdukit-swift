//
//  StatusCode.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation


/**
 * StatusCode - indicates the status code of the response. Success, warning, error.
 *
 */
public enum StatusCode: short {
    //Indicates successful processing of the command APDU
    case SUCCESSFUL_PROCESSING = 0x9000
    //Indicates warning that the read APDU worked but that this is the end of the file
    case WARNING_END_OF_FILE = 0x6282
    //Indicates that the request had an incorrect length
    case ERROR_INCORRECT_LENGTH = 0x6700
    //Indicates that the request was denied
    case ERROR_COMMAND_NOT_ALLOWED = 0x6986
    //Indicates that the requested file was not found
    case ERROR_FILE_NOT_FOUND = 0x6A82
    //Indicates that the command APDU had invalid parameters
    case ERROR_INVALID_PARAMETERS = 0x6A86
    //Indicates that the command APDU didn't have the right parameters
    case ERROR_WRONG_PARAMETERS = 0x6B00
    //Indicates a generic error.
    case ERROR_UNKNOWN = 0x6F00
    //Indicates access denied
    case ERROR_SECURITY_STATUS_NOT_SATISFIED = 0x6982
    
    //Returns a StatusCode for raw value byte.
    static func valueOf(code value: short?) -> StatusCode? {
        guard let value = value else { return nil }
        return StatusCode.init(rawValue: value)
    }
    
    func getValue() -> short {
        return self.rawValue
    }
}
