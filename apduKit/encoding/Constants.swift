//
//  Constants.swift
//  apduKit
//
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
internal struct Constants {
    internal static let DEFAULT_MAX_EXPECTED_LENGTH_EXTENDED = int(65536)
    internal static let TAG_BYTE_SIZE = 1
    internal static let DEFAULT_MAX_EXPECTED_LENGTH_NOT_EXTENDED = int(256)
    internal static let BYTE_OFFSET_TILL_LENGTH = Constants.TAG_BYTE_SIZE + 1//At least the tag and then the one byte of length
    internal static let SIZE_RESPONSE_STATUS_CODE = 2
    internal static let DEFAULT_ALGORITHM_INFO = byte(0x00)
    internal static let DEFAULT_CHALLENGE_LENGTH = int(8)
    internal static let DEFAULT_REFERENCE_DATA_QUALIFIER = byte(0x00)
}
