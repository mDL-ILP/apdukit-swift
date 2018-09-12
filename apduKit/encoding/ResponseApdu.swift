//
//  ResponseApdu.swift
//  apduKit
//
//  Created by Iain Munro on 29/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
public class ResponseApdu: Apdu {
    var statusCode: StatusCode?
    var data: [byte]?
    
    init(stream: ByteArrayInputStream) throws {
        try self.decodeData(stream)
        try self.decodeStatusCode(stream)
        try self.validate()
    }
    
    init() {
        
    }
    
    private func encodeStatusCode(_ stream: ByteArrayOutputStream) throws {
        guard let statusCode = self.statusCode else {
            return
        }
        stream.write(bytes: ConversionUtils.fromShortToBytes(statusCode.getValue()))
    }
    
    private func decodeStatusCode(_ stream: ByteArrayInputStream) throws {
        guard let statusCode = try? stream.readBytes(size: 2) else {
            throw ApduErrors.ParseException(description: "Missing 2 bytes for the status code")
        }
        self.statusCode = StatusCode.valueOf(code: try ConversionUtils.fromBytesToShort(statusCode))
    }
    
    private func encodeData(_ stream: ByteArrayOutputStream) throws {
        guard let data = self.data else {
            return
        }
        stream.write(bytes: data)
    }
    
    private func decodeData(_ stream: ByteArrayInputStream) throws {
        let issetData = stream.available() > Constants.SIZE_RESPONSE_STATUS_CODE
        if issetData {
            self.data = try stream.readBytes(size: stream.available() - Constants.SIZE_RESPONSE_STATUS_CODE)////Read all the data except the last two bytes which are reserved for the status code.
        }
    }
    
    /**
     * Apdu from bytes. Routes and initializes the right command APDU subclass depending on the instructionCode
     */
    static func fromBytes(_ buf: [byte]) throws -> ResponseApdu {
        return try ResponseApdu(stream: ByteArrayInputStream(bytes: buf))
    }
    
    public func validate() throws {
        guard self.statusCode != nil else {
            throw ApduErrors.ValueNotSetException(value: "statusCode")
        }
    }
    
    public func toBytes() throws -> ByteArrayOutputStream {
        try self.validate()
        let stream = ByteArrayOutputStream()
        try self.encodeData(stream)
        try self.encodeStatusCode(stream)
        return stream
    }
    
    
}
