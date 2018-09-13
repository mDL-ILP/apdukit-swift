//
//  ReaderApplicationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promise

public class ReaderApplicationLayer: ApplicationLayer, PresentationLayerDelegate {
    var appId: DedicatedFileID
    var presentationLayer: PresentationLayer
    //A lock so that we only get one file at a time.
    var getFileLock = DispatchSemaphore(value: 1)
    
    init(presentationLayer: PresentationLayer, appId: DedicatedFileID) {
        self.appId = appId
        self.presentationLayer = presentationLayer
        self.presentationLayer.set(delegate: self)
    }
    
    public func read(file id: ElementaryFileID) -> Promise<[byte]> {
        self.getFileLock.wait()
        return self.presentationLayer.select(DF: self.appId)
            .then({ (res) -> Promise<[byte]> in
                return self.openApduFile(fileID: id).then(self.resolveApduFile)
            })
            .always {
                self.getFileLock.signal()
            }
    }
    
    /**
     * Creates the intial first part of a APDU file by selecting the ElementaryFileID on at the holder and read a few initial bytes.
     * This is done to know how large the file is. As all APDU files are TLV (tag, length, value). We'll know what to expect size wise.
     * Then the resolveApduFile method can download any remaining bytes left.
     * @param fileID the ElementaryFileID that needs to be opened.
     * @return Promise of a ApduFile
     */
    private func openApduFile(fileID: ElementaryFileID) -> Promise<ApduFile> {
        var firstChunk: Promise<[byte]>!
        if fileID.isShortIDAvailable() {
            firstChunk = self.presentationLayer.readBinary(EF: fileID, offset: 0)
        } else {
            firstChunk = self.presentationLayer.select(EF: fileID)
                .then({ () -> Promise<[byte]> in
                    return self.presentationLayer.readBinary(offset: 0)
                })
        }
        return firstChunk.then({ (data) -> Promise<ApduFile> in
            do {
                let result = try ApduFile(data: data)
                return Promise<ApduFile>(value: result)
            } catch let e {
                return Promise<ApduFile>(error: e)
            }
        })
    }
    
    /**
     * This method will take a complete or incomplete APDu file and keeps reading until it is complete. Then return the bytes.
     * @param file APDU file. Created by reading the first 5 bytes or part of the file.\
     * @return
     */
    private func resolveApduFile(file: ApduFile) -> Promise<[byte]> {
        return Promise<[byte]>(work: { fulfill, reject in
            while(!file.isComplete()) {
                let offset = file.getCurrentSize()
                let promise = self.presentationLayer.readBinary(offset: byte(offset))
//                do {
//                    let data = try promise.getValue()
//                    try file.appendValue(value: data)
//                } catch let e {
//                    reject(e)
//                }
            }
            fulfill(file.getData())
        })
    }
    
    public func getLocalfile(id: ElementaryFileID) -> ApduFile? {
        return nil
    }
    
    public func getAppId() -> DedicatedFileID {
        return self.appId
    }
    
    public func isFileAllowed(file: ElementaryFileID) -> Bool {
        return false
    }
    
    //Abstract methods
    public func onSendFailure(exception: Error) {
        preconditionFailure("This method must be overridden")
    }
    
    public func onReceiveInvalidApdu(exception: Error) {
        preconditionFailure("This method must be overridden")
    }
    
}