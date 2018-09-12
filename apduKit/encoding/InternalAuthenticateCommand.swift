//
//  InternalAuthenticateCommand.swift
//  apduKit
//
//  Created by Iain Munro on 06/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//
import Foundation

public class InternalAuthenticateCommand: CommandApdu {
    var algorithmInfo: byte?
    var referenceDataQualifier: byte?
    var challenge: [byte]?
    var maxExpectedLength: int = Constants.DEFAULT_MAX_EXPECTED_LENGTH_EXTENDED
    
    init() {
        super.init(instructionCode: .INTERNAL_AUTHENTICATE)
    }
    
    override init(stream: ByteArrayInputStream) throws {
        try super.init(stream: stream)
        self.algorithmInfo = stream.readByte()
        self.referenceDataQualifier = stream.readByte()
        try self.decodeChallenge(stream)
        try self.decodeMaxExpectedLength(stream)
        try self.validate()
    }
    
    open func decodeChallenge(_ stream: ByteArrayInputStream) throws {
        guard let challengeLength = try? ApduLengthUtils.decodeDataLength(stream: stream) else {
            throw ApduErrors.ParseException(description: "Could not read data length")
        }
        self.challenge = try stream.readBytes(size: Int(challengeLength))
    }
    
    open func encodeChallenge(_ stream: ByteArrayOutputStream) throws {
        guard let challenge = self.challenge else { return }
        let challengeLength = ApduLengthUtils.encodeDataLength(length: short(challenge.count))
        stream.write(bytes: challengeLength)
        stream.write(bytes: challenge)
    }
    
    open func decodeMaxExpectedLength(_ stream: ByteArrayInputStream) throws {
        guard let maximumExpectedLength = try? ApduLengthUtils.decodeMaxExpectedLength(stream: stream) else {
            throw ApduErrors.ParseException(description: "Could not read max expected length")
        }
        self.maxExpectedLength = maximumExpectedLength
    }
    
    open func encodeMaxExpectedLength(_ stream: ByteArrayOutputStream) throws {
        let maximumExpectedLengthBuffer = try ApduLengthUtils.encodeMaxExpectedLength(length: self.maxExpectedLength)
        stream.write(bytes: maximumExpectedLengthBuffer)
    }
    
    override public func validate() throws {
        try super.validate()
        guard let instructionCode = self.instructionCode, instructionCode == .INTERNAL_AUTHENTICATE else {
            throw ApduErrors.InvalidApduException(description: "Instruction code is not INTERNAL_AUTHENTICATE")
        }
        guard let challenge = self.challenge, challenge.count == Constants.DEFAULT_CHALLENGE_LENGTH else {
            throw ApduErrors.InvalidApduException(description: "Invalid challenge")
        }
        guard self.algorithmInfo != nil else {
            throw ApduErrors.ValueNotSetException(value: "algorithmInfo")
        }
        guard self.referenceDataQualifier != nil else {
            throw ApduErrors.ValueNotSetException(value: "referenceDataQualifier")
        }
    }
    
    public override func toBytes() throws -> ByteArrayOutputStream {
        try validate()
        let stream = try super.toBytes()
        stream.write(byte: self.algorithmInfo!)
        stream.write(byte: self.referenceDataQualifier!)
        try encodeChallenge(stream)
        try encodeMaxExpectedLength(stream)
        return stream
    }
    
}
