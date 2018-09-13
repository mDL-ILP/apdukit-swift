//
//  ReadBinaryShortFileIDCommand.swift
//  apduKit
//  Read binary data and pass along the file id.
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

class ReadBinaryShortFileIDCommand: ReadBinaryCommand {
    private(set) var elementaryFileID: ElementaryFileID!
    private(set) var offset: byte?
    
    override init() {
        super.init()
    }
    
    override init(stream: ByteArrayInputStream) throws {
        try super.init(stream: stream)
        try self.decodeElementaryFileID(stream)
        try self.decodeOffset(stream)
        try self.decodeMaximumExpectedLength(stream)
        try self.validate()
    }
    
    private func decodeOffset(_ stream: ByteArrayInputStream) throws {
        self.offset = stream.readByte()
    }
    
    private func encodeOffset(_ stream: ByteArrayOutputStream) throws {
        guard let offset = self.offset else { return }
        stream.write(byte: offset)
    }
    
    private func decodeElementaryFileID(_ stream: ByteArrayInputStream) throws {
        guard var shortFileIdByte = stream.readByte() else {
            throw ApduErrors.ParseException(description: "Missing short file id")
        }
        shortFileIdByte = ConversionUtils.replaceBit8with0(shortFileIdByte)
        self.elementaryFileID = try ElementaryFileID(shortIdentifier: shortFileIdByte)
    }
    
    private func encodeElementaryFileID(_ stream: ByteArrayOutputStream) throws {
        guard let elementaryFileID = self.elementaryFileID else {
            throw ApduErrors.InvalidApduException(description: "No elementary file id set")
        }
        guard let shortIdentifier = try elementaryFileID.getShortIdentifier() else {
            throw ApduErrors.InvalidApduException(description: "No elementary file id set")
        }
        stream.write(byte: ConversionUtils.replaceBit8with1(shortIdentifier))
    }
    
    override func validate() throws {
        try super.validate()
        guard self.elementaryFileID != nil else {
            throw ApduErrors.ValueNotSetException(value: "elementaryFileID")
        }
    }
    
    override func toBytes() throws -> ByteArrayOutputStream {
        try validate()
        let stream = try super.toBytes()
        try self.encodeElementaryFileID(stream)
        try self.encodeOffset(stream)
        try self.encodeMaximumExpectedLength(stream)
        return stream
    }
    
    func set(offset: byte) -> ReadBinaryShortFileIDCommand {
        self.offset = offset
        return self
    }
    
    func set(elementaryFileID: ElementaryFileID) -> ReadBinaryShortFileIDCommand {
        self.elementaryFileID = elementaryFileID
        return self
    }
    
}
