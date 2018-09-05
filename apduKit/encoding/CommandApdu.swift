//
//  CommandApdu.swift
//  apduKit
//
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

/**
 * CommandApdu is an abstract class that defines the base apdu request. Selects, reads etc.
 *
*/
class CommandApdu: Apdu {
    //Indicates the type of command, e.g. inter industry or proprietary
    var instructionClass: InstructionClass? = InstructionClass.DEFAULT
    //Indicates the specific command, e.g. "select file"
    var instructionCode: InstructionCode?
    
    init(stream: ByteArrayInputStream) throws {
        self.instructionClass = InstructionClass.valueOf(byte: stream.readByte())
        self.instructionCode = InstructionCode.valueOf(byte: stream.readByte())
    }
    
    init(instructionCode: InstructionCode) {
        self.instructionCode = instructionCode
    }
    
    /**
     * Apdu from bytes. Routes and initializes the right apdu subclass depending on the instructionCode
     */
    static func fromBytes(_ buf: [byte]) throws -> CommandApdu? {
        let stream = ByteArrayInputStream(bytes: buf)
        if stream.available() < 4 {
            throw ApduErrors.ParseException(description: "data should be at least 4 long")
        }
        stream.skip(1)//Skip instruction class.
        guard let instructionCode = InstructionCode.valueOf(byte: stream.readByte()) else { return nil }
        stream.reset()
        switch instructionCode {
        case .SELECT:
            return try SelectCommand(stream: stream)
        case .READ_BINARY:
            return try ReadBinaryCommand.fromBytes(stream: stream)
        }
    }
    
    /**
     * Validate Apdu. Each type will throw if values aren't set etc.
     */
    func validate() throws {
        guard self.instructionClass != nil else {
            throw ApduErrors.ValueNotSetException(value: "instructionClass")
        }
        guard self.instructionCode != nil else {
            throw ApduErrors.ValueNotSetException(value: "instructionCode")
        }
    }
    
    /**
     * Apdu to bytes.
     */
    func toBytes() throws -> ByteArrayOutputStream {
        try self.validate()
        let stream = ByteArrayOutputStream()
        stream.write(byte: self.instructionClass!.getValue())
        stream.write(byte: self.instructionCode!.getValue())
        return stream
    }
    
}
