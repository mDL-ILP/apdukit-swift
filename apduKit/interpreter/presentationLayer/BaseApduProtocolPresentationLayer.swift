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
    
    init(sessionLayer: SessionLayer) {
        self.sessionLayer = sessionLayer
        self.sessionLayer.set(delegate: self)
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
     * Routes call to right EF read. If short it'll use the short id otherwise it'll use the normal.
     * @param fileID
     * @return
     */
    public func read(EF fileID: ElementaryFileID) -> Promise<[byte]> {
        var data: [byte] = []
        return Promise<[byte]>(value: data)
    }
    
    /**
     * Creates the intial first part of a APDU file by selecting the ElementaryFileID on at the holder and read a few initial bytes.
     * @param fileID
     * @return
     */
    /*
    private func openApduFile(fileID: ElementaryFileID) -> Promise<ApduFile> {
        var promise: Promise<[byte]>
        //If short file id is available, a read will also instantly select the file.
        if fileID.isShortIDAvailable() {
//            promise = self.read
        } else {
            promise = selectedEF(fileID).
        }
        return promise.then({ (data) in
            do {
                let result = ApduFile(
            }
        })
    }
*/
    
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
    
    public func receivedReadCommand(command: ReadBinaryCommand) -> ResponseApdu {
        return ResponseApdu()
    }
    
    public func receivedSelectCommand(command: SelectCommand) -> ResponseApdu {
        return ResponseApdu()
    }
    
    public func onSendFailure(exception: Error) {
        self.delegate?.onSendFailure(exception: exception)
    }
    
    public func onReceiveInvalidApdu(exception: Error) {
        self.delegate?.onReceiveInvalidApdu(exception: exception)
    }
}
