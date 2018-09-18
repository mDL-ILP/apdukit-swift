//
//  BytesAndNumericsUtils.swift
//  apduKit
//  Utility class to convert bytes, bits etc.
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

class ConversionUtils {
    /**
     * Given a short value, convert it to bytes.
     * @param value that needs to be converted
     * @return bytes that represent the given short value
     */
    internal static func fromShortToBytes(_ value: short) -> [byte] {
        let byte1 = byte((value >> 8) & 0xFF)
        let byte2 = byte(value & 0xFF)
        return [byte1, byte2]
    }
    
    /**
     * Given a bytes, convert it a short.
     * @param value that needs to be converted
     * @return short that represent the given byte value
     */
    internal static func fromBytesToShort(_ value: [byte]) throws -> short {
        //We will only do shorts.
        if value.count > 2 {
            throw ConversionUtilsErrors.InvalidNumericValueException(description: "Too many bytes to represent a short. Short is 2 bytes long.")
        }
        if value.count == 1 {
            return short(value[0])
        }
        var result: short = 0
        let data = NSData(bytes: value, length: value.count)
        data.getBytes(&result, length: value.count)
        return short(bigEndian: result)
    }
    
    /**
     * Converts bytes to bits
     * @param b bytes
     * @return array of bits for each byte. b.lenght * 8
     */
    internal static func bytesToBits(bytes: [byte]) -> [byte] {
        var result: [byte] = []
        result.reserveCapacity(bytes.count * 8)
        for byte in bytes {
            let bits = byteToBits(byte: byte)
            result.append(contentsOf: bits)
        }
        return result
    }
    
    /**
     * converts byte to bits
     * @param value byte
     * @return array of bits max 8 long.
     */
    internal static func byteToBits(byte value: byte) -> [byte] {
        var result = Array<byte>(repeating: 0, count: 8)
        result[7] = (value & 0x01) != 0 ? 1 : 0
        result[6] = (value & 0x02) != 0 ? 1 : 0
        result[5] = (value & 0x04) != 0 ? 1 : 0
        result[4] = (value & 0x08) != 0 ? 1 : 0
        result[3] = (value & 0x10) != 0 ? 1 : 0
        result[2] = (value & 0x20) != 0 ? 1 : 0
        result[1] = (value & 0x40) != 0 ? 1 : 0
        result[0] = (value & 0x80) != 0 ? 1 : 0
        return result
    }
    
    /**
     * converts 8 bits to one byte
     * @param bits 8 bits.
     * @return The byte of the bits.
     */
    internal static func bitsToByte(bits: [byte]) -> byte {
        if(bits.count != 8) {
            return 0;
        }
        var result: byte = 0;
        if bits[7] == 1 {
            result += 1
        }
        if (bits[6] == 1) {
            result += 2
        }
        if (bits[5] == 1) {
            result += 4
        }
        if (bits[4] == 1) {
            result += 8
        }
        if (bits[3] == 1) {
            result += 16
        }
        if (bits[2] == 1) {
            result += 32
        }
        if (bits[1] == 1) {
            result += 64
        }
        if (bits[0] == 1) {
            result += 128
        }
        return result;
    }
    
    /**
     * replaces the 8th bit with a 0
     * @param value that needs to be replaced
     * @return replaced value
     */
    internal static func replaceBit8with0(_ value: byte) -> byte{
        return (value & ~(1 << 7))
    }
    
    /**
     * replaces the 8th bit with a 1
     * @param value that needs to be replaced
     * @return replaced value
     */
    internal static func replaceBit8with1(_ value: byte) -> byte{
        return (value | (1 << 7))
    }
    
    /**
     * Returns true if the first three bits of the given byte are 0.0.0
     * @param value that needs to be checked
     * @return boolean returning if the statement is true
     */
    internal static func areTheFirstThreeBitsZero(value: byte) -> Bool {
        let bits = byteToBits(byte: value)
        return bits[0] == 0 && bits[1] == 0 && bits[2] == 0
    }
    
    /**
     * Returns true if the first three bits of the given byte are a 1.0.0
     * @param value that needs to be checked
     * @return boolean returning if the statement is true
     */
    internal static func areTheFirstThreeBits100(value: byte) -> Bool {
        let bits = byteToBits(byte: value)
        return bits[0] == 1 && bits[1] == 0 && bits[2] == 0
    }
    
}
