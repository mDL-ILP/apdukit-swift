//
//  Errors.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

internal enum ApduErrors: Error {
    case ValueNotSetException(value: String)
    case ParseException(description: String)
    case InvalidApduException(description: String)
    case InvalidElementaryFileId(description: String)
    case InvalidNumericException(description: String)
    case InvalidApduFileException(description: String)
}
