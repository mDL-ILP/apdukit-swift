//
//  ApduLengthUtils.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * All the utilities methods to get the data or expected length of an apdu.
 * Utils written according to ISO 7816-4.
 * All magic numbers in this class come from the said ISO standard.
 */
class ApduLengthUtils {
    
    /**
     * Parse the LE field of the command apdu.
     * English: Parse the expected response length. This is only at the end of the apdu stream.
     * This will not touch the stream
     * See: 5.1 Command-response pairs in ISO 7816-4.
     * @param stream
     * @return length
     * @throws ParseException
     * @throws InvalidNumericException
     */
    public static func decodeMaxExpectedLength(stream: ByteArrayInputStream) throws -> short {
        guard let firstByte = stream.readByte() else {
            throw ApduErrors.ParseException(description: "Not enough bytes given to read expected length")
        }
        let secondByte = stream.readByte()
        let thirdByte = stream.readByte()
        
        if firstByte == 0 {
            //If there are two bytes left in the stream. Read it as a short (extended length)
            if secondByte != nil && thirdByte != nil {
                return try ConversionUtils.fromBytesToShort([secondByte!, thirdByte!])
            }
            //If the byte is set to '00', then Ne is 256.
            if secondByte == nil && thirdByte == nil {
                return 256
            }
            //If the two bytes are set to '0000', then Ne is 65 536.
            if secondByte != nil && secondByte == 0 && thirdByte == nil {
                return Constants.EXTENDED_LENGTH
            }
        } else {
            //From '01' to 'FF', the byte encodes Nc from one to 255.
            if secondByte == nil && thirdByte == nil {
                return short(firstByte)
            }
        }
        throw ApduErrors.ParseException(description: "Unhandled or invalid expected length.")
    }
    
    /**
     * Parse the data length. This can be in the middle of the apdu stream and takes care of both the extended and normal length type.
     * @param stream
     * @return
     * @throws ParseException
     * @throws InvalidNumericException
     */
    public static func decodeDataLength(stream: ByteArrayInputStream) throws -> short {
        guard let firstByte = stream.readByte() else {
            throw ApduErrors.ParseException(description: "Not enough bytes given to read data length.")
        }
        let isExtendedLength = firstByte == 0
        
        var result: short = 0//length
        if !isExtendedLength && stream.available() == firstByte {
            result = short(firstByte)
        } else {
            let secondByte = stream.readByte()
            let thirdByte = stream.readByte()
            if secondByte != nil && thirdByte != nil {
                result = try ConversionUtils.fromBytesToShort([secondByte!, thirdByte!])
            }
        }
        if result == 0 || stream.available() != result {
            throw ApduErrors.ParseException(description: "Supplied length does not match any possible remaining data length")
        }
        return result
    }
    
    /**
     * For a given data length encodes it in either 1 byte or 3 bytes depending if the passed length value can be represented using one byte.
     * In the case that value is too large the method will return a short of 2 bytes with a single 0 byte to indicate that it is extended length
     * @param length
     * @return byte array representing the given length.
     */
    public static func encodeDataLength(length: short) -> [byte] {
        if length == Constants.EXTENDED_LENGTH {
            return [0x00, 0x00]
        }
        if length == 256 {
            return [0x00]
        }
        let parts = ConversionUtils.fromShortToBytes(length)
        //Is the first part not 0? Meaning its bigger than one byte? Then use extended length
        if parts[0] != 0 {
            return [0x0, parts[0], parts[1]]
        }
        return [parts[1]]
    }
    
    public static func encodeMaxExpectedLength(length: short) -> [byte] {
        return encodeDataLength(length: length)
    }
}
