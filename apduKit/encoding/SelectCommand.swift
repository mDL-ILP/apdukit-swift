//
//  SelectCommand.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
/**
* SelectCommand - Is a apdu command that allows to select a file. This is done by specifying a dedicated or elementary file id.
*/
class SelectCommand: CommandApdu {
    private(set) var fileType: SelectFileType?
    var expectedResult: ExpectedResultType?
    var fileID: FileID? {
        didSet {
            if self.fileID is DedicatedFileID {
                self.fileType = .DF
            }
            if self.fileID is ElementaryFileID {
                self.fileType = .EF
            }
        }
    }
    
    init() {
        super.init(instructionCode: .SELECT)
    }
    
    override init(stream: ByteArrayInputStream) throws {
        try super.init(stream: stream)
        self.fileType = SelectFileType.valueOf(code: stream.readByte())
        self.expectedResult = ExpectedResultType.valueOf(code: stream.readByte())
        try self.decodeFileId(stream)
    }
    
    private func decodeFileId(_ stream: ByteArrayInputStream) throws {
        let fileIdLength = try ApduLengthUtils.decodeDataLength(stream: stream)
        let fileId = try stream.readBytes(size: Int(fileIdLength))
        switch self.fileType! {
            case .EF:
                self.fileID = try ElementaryFileID(normalIdentifier: ConversionUtils.fromBytesToShort(fileId))
                break
            case .DF:
                self.fileID = DedicatedFileID(fileId)
                break
        }
    }
    
    private func encodeFileId(_ stream: ByteArrayOutputStream) throws {
        guard let fileId = self.fileID?.getValue() else {
            throw ApduErrors.InvalidApduException(description: "No file id set")
        }
        let fileIdLength = ApduLengthUtils.encodeDataLength(length: short(fileId.count))
        stream.write(bytes: fileIdLength)
        stream.write(bytes: fileId)
    }
    
    override func validate() throws {
        try super.validate()
        guard let instructionCode = self.instructionCode, instructionCode == .SELECT else {
            throw ApduErrors.InvalidApduException(description: "InstructionCode is not SELECT")
        }
        guard self.fileID != nil else {
            throw ApduErrors.ValueNotSetException(value: "fileID")
        }
        guard let fileType = self.fileType else {
            throw ApduErrors.ValueNotSetException(value: "fileType")
        }
        //Check that the filetype is correct.
        if fileType == .DF && !(self.fileID is DedicatedFileID) {
            throw ApduErrors.InvalidApduException(description: "filetype does not match file id instance type")
        }
        if fileType == .EF && !(self.fileID is ElementaryFileID) {
            throw ApduErrors.InvalidApduException(description: "filetype does not match file id instance type")
        }
        guard self.expectedResult != nil else {
            throw ApduErrors.ValueNotSetException(value: "expectedResult")
        }
    }
    
    override func toBytes() throws -> ByteArrayOutputStream {
        try validate()
        let stream = try super.toBytes()
        stream.write(byte: fileType!.getValue())
        stream.write(byte: expectedResult!.getValue())
        try encodeFileId(stream)
        return stream
    }
    
}
