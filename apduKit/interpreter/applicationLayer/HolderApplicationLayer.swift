//
//  HolderApplicationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

public class HolderApplicationLayer: ApplicationLayer, PresentationLayerDelegate {
    var appId: DedicatedFileID
    var presentationLayer: PresentationLayer
    
    //State
    private var localFiles = [short: ApduFile]()
    
    init(presentationLayer: PresentationLayer, appId: DedicatedFileID) {
        self.appId = appId
        self.presentationLayer = presentationLayer
        self.presentationLayer.set(delegate: self)
    }
    
    func setLocalFile(id: ElementaryFileID, data: [byte]) throws -> Bool {
        let file = try ApduFile(data: data)
        if !file.isComplete() {
            return false
        }
        let normalId: short = try id.getNormalIDValueAsAShort()
        localFiles[normalId] = file
        do {
            let shortId: short = try id.getShortIDValueAsAShort()
            localFiles[shortId] = file
        } catch {}
        return true
    }
    
    /**
     * Returns back a local file from this.files. Trying both short and normal.
     *
     * @param id elementaryFileID specifying the file
     * @return an ApduFile
     */
    public func getLocalfile(id: ElementaryFileID) -> ApduFile? {
        if let key = try! id.getShortIdentifier() {
            if let result = localFiles[short(key)] {
                return result
            }
        }
        if let key = try? id.getNormalIDValueAsAShort() {
            if let result = localFiles[short(key)] {
                return result
            }
        }
        return nil
    }
    
    /**
     *  Delegate method that informs the presentation layer what the id is of this app.
     * @return the current dedicated file id
     */
    public func getAppId() -> DedicatedFileID {
        return self.appId
    }
    
    //Abstract methods
    public func isFileAllowed(file: ElementaryFileID) -> Bool {
        preconditionFailure("This method must be overridden")
    }
    
    public func onSendFailure(exception: Error) {
        preconditionFailure("This method must be overridden")
    }
    
    public func onReceiveInvalidApdu(exception: Error) {
        preconditionFailure("This method must be overridden")
    }
    
}
