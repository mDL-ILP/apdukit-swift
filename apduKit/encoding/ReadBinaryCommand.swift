//
//  ReadBinaryCommand.swift
//  apduKit
//  Abstract class to serve for all readbinary commands.
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

class ReadBinaryCommand: CommandApdu {
    var maximumExpectedLength: short = 0//0 means EXTENDED_LENGTH. 65535.
    
    init() {
        super.init(instructionCode: .READ_BINARY)
    }
    
    override init(stream: ByteArrayInputStream) throws {
        try super.init(stream: stream)
    }
    
    override func validate() throws {
        try super.validate()
        guard let instructionCode = self.instructionCode, instructionCode == .READ_BINARY else {
            throw ApduErrors.InvalidApduException(description: "InstructionCode is not READ_BINARY")
        }
    }
    
    open func decodeMaximumExpectedLength(_ stream: ByteArrayInputStream) throws {
        guard let maximumExpectedLength = try? ApduLengthUtils.decodeMaxExpectedLength(stream: stream) else {
            throw ApduErrors.ParseException(description: "Could not read max expected length")
        }
        self.maximumExpectedLength = maximumExpectedLength
    }
    
    open func encodeMaximumExpectedLength(_ stream: ByteArrayOutputStream) throws {
        let maximumExpectedLengthBuffer = ApduLengthUtils.encodeMaxExpectedLength(length: self.maximumExpectedLength)
        stream.write(bytes: maximumExpectedLengthBuffer)
    }
    
    /**
     * Apdu from bytes. Routes and initializes the right read binary subclass depending on the file id bits.
     */
    static func fromBytes(stream: ByteArrayInputStream) throws -> ReadBinaryCommand? {
        stream.skip(2)//Skip the instruction class + instruction code
        guard let fileIdFirstByte = stream.readByte() else { return nil }
        stream.reset()
        if ConversionUtils.areTheFirstThreeBits100(value: fileIdFirstByte) {
            return try ReadBinaryShortFileIDCommand(stream: stream)
        }
        return try ReadBinaryOffsetCommand(stream: stream)
    }
}
