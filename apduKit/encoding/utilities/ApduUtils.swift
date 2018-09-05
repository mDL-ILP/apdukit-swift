//
//  ApduUtils.swift
//  apduKit
//  All the APDU cheat codes on planet earth.
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public struct TLVInfo {
    ///Tag
    var tag: int
    ///Length of the TLV structure
    var length: short
    ///At what offset the actual data (value) starts
    var dataOffset: int
}

public class ApduUtils {
    
    /**
     * Parses a TLV structure and returns the tag, length and dataOffset
     * @param data TLV data
     * @return TLVInfo containing TLV information
     */
    func parseTLV(bytes data: [byte]) -> TLVInfo? {
        if data.count < Constants.BYTE_OFFSET_TILL_LENGTH {
            return nil
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
                return nil
            }
            lengthBytes = Array(data[Int(Constants.BYTE_OFFSET_TILL_LENGTH)...Int(lengthEndOffset)])
            dataOffset = Int(lengthEndOffset)
        }
        guard let length = try? ConversionUtils.fromBytesToShort(lengthBytes) else { return nil }
        return TLVInfo(tag: int(tag), length: short(length), dataOffset: int(dataOffset))
    }
    
}
