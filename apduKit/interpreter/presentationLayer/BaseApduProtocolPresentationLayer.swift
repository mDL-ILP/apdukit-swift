//
//  BaseApduProtocolPresentationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promise

/**
 * The base APDU protocol presentation layer. It keeps state of what DF and EF are selected. Exposes methods to select DF or EF.
 */
public class BaseApduProtocolPresentationLayer: PresentationLayer {
    var delegate: PresentationLayerDelegate?
    var sessionLayer: SessionLayer
    
    //State
    var selectedDF: DedicatedFileID?
    var selectedEF: ElementaryFileID?
    private var maxExpLength = Constants.DEFAULT_MAX_EXPECTED_LENGTH_NOT_EXTENDED
    
    init(sessionLayer: SessionLayer) {
        self.sessionLayer = sessionLayer
    }
    
    /**
     * Select a dedicated file (app)
     * @param fileID
     * @return
     */
    public func select(DF fileID: DedicatedFileID) -> Promise<()> {
        if self.selectedDF == fileID {
            return Promise<()>(value: ())
        }
        let command = SelectCommand()
            .set(fileControlInfo: .NOFCIReturn)
            .set(fileID: fileID)
        return self.sessionLayer.send(command: command)
            .then(readSelectResponse)
            .then { (result) -> Promise<()> in
                self.selectedDF = fileID
                return Promise<()>(value: ())
            }
    }
    
    /**
     * Select an elementary file (file, datagroup)
     * @param fileID
     * @return
     */
    public func select(EF fileID: ElementaryFileID) -> Promise<()> {
        if self.selectedEF == fileID {
            return Promise<()>(value: ())
        }
        let command = SelectCommand()
            .set(fileControlInfo: .NOFCIReturn)
            .set(fileID: fileID)
        return self.sessionLayer.send(command: command)
            .then(self.readSelectResponse)
            .then { (result) -> Promise<()> in
                self.selectedEF = fileID
                return Promise<()>(value: ())
        }
    }
    
    /**
     * Read contents of EF using shortID.
     * @param fileID specifying the file
     * @param offset the offset of the data. Cannot exceed the file size.
     * @return bytes of the file
     */
    public func readBinary(EF fileID: ElementaryFileID, offset: byte) -> Promise<[byte]> {
        let command = ReadBinaryShortFileIDCommand()
            .set(offset: offset)
            .set(elementaryFileID: fileID)
        _ = command.set(maximumExpectedLength: self.maxExpLength)
        return self.sessionLayer.send(command: command).then(readReadBinaryResponse)
    }
    
    /**
     * Read contents of EF using normalID. The EF must first be selected.
     * @param offset the offset of the data. Cannot exceed the file size.
     * @return bytes of the file
     */
    public func readBinary(offset: byte) -> Promise<[byte]> {
        let command = ReadBinaryOffsetCommand()
            .set(offset: short(offset))
        _ = command.set(maximumExpectedLength: self.maxExpLength)
        return self.sessionLayer.send(command: command).then(readReadBinaryResponse)
    }
    
    /**
     * Reads the response APDU and returns a new promise that will be rejected if the status code is not SUCCESSFUL
     * @param response
     * @return promise with the response
     */
    private func readSelectResponse(response: ResponseApdu) -> Promise<ResponseApdu> {
        let statusCode = response.statusCode!
        if statusCode == .SUCCESSFUL_PROCESSING {
            return Promise<ResponseApdu>(value: response)
        } else {
            return Promise<ResponseApdu>(error: InterpeterErrors.ResponseApduStatusCodeError(code: statusCode))
        }
    }
    
    /**
     * Reads the response APDU and returns the data of the response
     * @param response
     * @return the binary data from the response
     */
    private func readReadBinaryResponse(response: ResponseApdu) -> Promise<[byte]> {
        let statusCode = response.statusCode!
        if statusCode == .SUCCESSFUL_PROCESSING || statusCode == .WARNING_END_OF_FILE {
            if let data = response.data {
                return Promise<[byte]>(value: data)
            }
            return Promise<[byte]>(error: InterpeterErrors.Exception(message: "No data in response"))
        }
        return Promise<[byte]>(error: InterpeterErrors.ResponseApduStatusCodeError(code: statusCode))
    }
    
    
    public func set(delegate: PresentationLayerDelegate) {
        self.delegate = delegate
    }
}
