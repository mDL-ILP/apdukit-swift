//
//  ApduProtocolPresentationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

/**
 *  The handle apdu protocol presentation layer. Extends the base apdu protocol layer with methods to know of to handle requests
 */
internal class ApduProtocolPresentationLayer: BaseApduProtocolPresentationLayer, SessionLayerDelegate {
    
    override init(sessionLayer: SessionLayer) {
        super.init(sessionLayer: sessionLayer)
        self.sessionLayer.set(delegate: self)
    }
    
    internal func receivedSelectCommand(command: SelectCommand) -> ResponseApdu {
        let type = command.fileType!
        let requestedFileId = command.fileID
        var success = false
        switch type {
        case .DF:
            success = setSelected(DF: requestedFileId as? DedicatedFileID)
            break
        case .EF:
            success = setSelected(EF: requestedFileId as? ElementaryFileID)
            break
        }
        return ResponseApdu().set(statusCode: success ? StatusCode.SUCCESSFUL_PROCESSING : StatusCode.ERROR_FILE_NOT_FOUND)
    }
    
    internal func receivedReadCommand(command: ReadBinaryCommand) -> ResponseApdu {
        var id = self.selectedEF
        if let readShortCommand = command as? ReadBinaryShortFileIDCommand {
            id = readShortCommand.elementaryFileID
            self.selectedEF = id
        }
        guard let fileId = id, let file = self.delegate?.getLocalfile(id: fileId) else {
            return ResponseApdu().set(statusCode: .ERROR_FILE_NOT_FOUND)
        }
        guard delegate != nil && delegate!.isFileAllowed(file: fileId) else {
            return ResponseApdu().set(statusCode: .ERROR_SECURITY_STATUS_NOT_SATISFIED)
        }
        return buildResponseOnRead(file: file, offset: command.getOffset(), maximumExpectedLength: command.maximumExpectedLength)
    }
    
    private func buildResponseOnRead(file: ApduFile, offset: short, maximumExpectedLength: int) -> ResponseApdu {
        let response = ResponseApdu()
        let data = file.getData()
        var readStartIndex: Int = Int(offset)
        var readEndIndex: Int = Int(offset + short(maximumExpectedLength))
        let askedForTooMuch = readEndIndex > data.count//EndOffset is the index of how far we'll read.
        if readStartIndex > data.count {
            readStartIndex = data.count-1
        }
        if askedForTooMuch {//Cap it to the length of the data.
            readEndIndex = data.count-1
        }
        //If the given offset is too high or there is nothing to send back.
        if readStartIndex >= readEndIndex {
            return ResponseApdu().set(statusCode: .ERROR_COMMAND_NOT_ALLOWED)
        }
        let payload = Array(data[readStartIndex...readEndIndex])
        return ResponseApdu()
            .set(statusCode: askedForTooMuch ? StatusCode.WARNING_END_OF_FILE : StatusCode.SUCCESSFUL_PROCESSING)
            .set(data: payload)
    }
    
    /**
     * Sets the selected app id (DedicatedFileID)and returns if this was successful.
     *
     * @param id dedicatedFileID specifying the app id
     * @return boolean indicating if the set was successful.
     */
    private func setSelected(DF id: DedicatedFileID?) -> Bool {
        guard let requestedId = id, requestedId == self.delegate?.getAppId() else { return false }
        self.selectedDF = requestedId
        return true
    }
    
    /**
     * Set the selected file id (elementaryFileID) and returns if this was successful.
     *
     * @param id elementaryFileID specifying the file
     * @return boolean indicating if the set was successful.
     */
    private func setSelected(EF id: ElementaryFileID?) -> Bool {
        //You can only select an EF after you've selected an app.
        if selectedDF == nil {
            return false
        }
        guard let requestedId = id, self.delegate?.getLocalfile(id: requestedId) != nil else { return false }
        self.selectedEF = id
        return true
    }
    
    internal func onSendFailure(exception: Error) {
        self.delegate?.onSendFailure(exception: exception)
    }
    
    internal func onReceiveInvalidApdu(exception: Error) {
        self.delegate?.onReceiveInvalidApdu(exception: exception)
    }
}
