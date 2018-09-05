//
//  Constants.swift
//  apduKit
//
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
public struct Constants {
    public static let EXTENDED_LENGTH = short(short.max)//Standard says 65536, but you can't represent a value that high in a short.
    public static let TAG_BYTE_SIZE = 1
    public static let DEFAULT_MAX_EXPECTED_LENGTH = 0//0 means 255
    public static let BYTE_OFFSET_TILL_LENGTH = Constants.TAG_BYTE_SIZE + 1//At least the tag and then the one byte of length
    public static let SIZE_RESPONSE_STATUS_CODE = 2
}
