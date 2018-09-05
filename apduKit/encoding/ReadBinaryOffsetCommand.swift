//
//  ReadBinaryOffsetCommand.swift
//  apduKit
//
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

class ReadBinaryOffsetCommand: ReadBinaryCommand {
    
    var offset: short = 0;
    
    override init() {
        super.init()
    }
    
    override init(stream: ByteArrayInputStream) throws {
        try super.init(stream: stream)
        try self.decodeOffset(stream)
        try self.decodeMaximumExpectedLength(stream)
        try self.validate()
    }
    
    private func decodeOffset(_ stream: ByteArrayInputStream) throws {
        guard let offsetBuffer = try? stream.readBytes(size: 2) else {
            throw ApduErrors.ParseException(description: "Could not read file id")
        }
        self.offset = try ConversionUtils.fromBytesToShort(offsetBuffer)
    }
    
    private func encodeOffset(_ stream: ByteArrayOutputStream) throws {
        let offsetBuffer = ConversionUtils.fromShortToBytes(self.offset)
        stream.write(bytes: offsetBuffer)
    }
    
    override func toBytes() throws -> ByteArrayOutputStream {
        try validate()
        let stream = try super.toBytes()
        try self.encodeOffset(stream)
        try self.encodeMaximumExpectedLength(stream)
        return stream
    }
}
