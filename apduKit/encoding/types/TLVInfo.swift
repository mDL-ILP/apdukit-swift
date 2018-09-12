//
//  TLVInfo.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public class TLVInfo {
    /// Tag
    private(set) var tag: int
    /// Length of the TLV structure
    private(set) var length: short
    /// At what offset the actual data (value) starts
    private(set) var dataOffset: int
    
    /**
     * Parses a TLV structure and returns the tag, length and dataOffset
     * @param data TLV data
     * @return TLVInfo containing TLV information
     */
    init(data: [byte]) throws {
        if data.count < Constants.BYTE_OFFSET_TILL_LENGTH {
            throw ApduErrors.ParseException(description: "Not enough bytes to parse TLV structure")
        }
        var dataOffset = Constants.BYTE_OFFSET_TILL_LENGTH
        let tag = Int(data[0])
        var lengthBytes = [data[1]]
        //Check if the length value exceeds 255
        var bits = ConversionUtils.byteToBits(byte: data[1])
        //If the first bit is 1, this tells us that the value is higher than 255.
        //If its 1, just read the byte.
        if bits[0] == 1 {
            bits[0] = 0//Skip the firt bit. Then read the bits after.
            let lengthValueSize = int(ConversionUtils.bitsToByte(bits: bits))
            let lengthEndOffset = int(Constants.BYTE_OFFSET_TILL_LENGTH) + lengthValueSize
            if data.count < lengthEndOffset {
                throw ApduErrors.ParseException(description: "Invalid TLV structure. Length doesn't make any sense")
            }
            lengthBytes = Array(data[Int(Constants.BYTE_OFFSET_TILL_LENGTH)...Int(lengthEndOffset)])
            dataOffset = Int(lengthEndOffset)
        }
        let length = try ConversionUtils.fromBytesToShort(lengthBytes)
        self.tag = tag
        self.length = length
        self.dataOffset = dataOffset
    }
    
}
