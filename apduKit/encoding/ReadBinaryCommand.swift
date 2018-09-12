//
//  ReadBinaryCommand.swift
//  apduKit
//  Abstract class to serve for all readbinary commands.
//  Created by Iain Munro on 30/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public class ReadBinaryCommand: CommandApdu {
    private(set) var maximumExpectedLength: int = 0//0 means EXTENDED_LENGTH. 65535.
    
    init() {
        super.init(instructionCode: .READ_BINARY)
    }
    
    override init(stream: ByteArrayInputStream) throws {
        try super.init(stream: stream)
    }
    
    open func decodeMaximumExpectedLength(_ stream: ByteArrayInputStream) throws {
        guard let maximumExpectedLength = try? ApduLengthUtils.decodeMaxExpectedLength(stream: stream) else {
            throw ApduErrors.ParseException(description: "Could not read max expected length")
        }
        self.maximumExpectedLength = maximumExpectedLength
    }
    
    open func encodeMaximumExpectedLength(_ stream: ByteArrayOutputStream) throws {
        let maximumExpectedLengthBuffer = try ApduLengthUtils.encodeMaxExpectedLength(length: self.maximumExpectedLength)
        stream.write(bytes: maximumExpectedLengthBuffer)
    }
    
    override public func validate() throws {
        try super.validate()
        guard let instructionCode = self.instructionCode, instructionCode == .READ_BINARY else {
            throw ApduErrors.InvalidApduException(description: "InstructionCode is not READ_BINARY")
        }
    }
    
    /**
     * Apdu from bytes. Routes and initializes the right read binary subclass depending on the file id bits.
     */
    static public func fromBytes(stream: ByteArrayInputStream) throws -> ReadBinaryCommand {
        stream.skip(2)//Skip the instruction class + instruction code
        guard let fileIdFirstByte = stream.readByte() else {
            throw ApduErrors.ParseException(description: "Could not read first byte of file id")
        }
        stream.reset()
        if ConversionUtils.areTheFirstThreeBits100(value: fileIdFirstByte) {
            return try ReadBinaryShortFileIDCommand(stream: stream)
        }
        return try ReadBinaryOffsetCommand(stream: stream)
    }
    
    func set(maximumExpectedLength: int) -> ReadBinaryCommand {
        self.maximumExpectedLength = maximumExpectedLength
        return self
    }
}
