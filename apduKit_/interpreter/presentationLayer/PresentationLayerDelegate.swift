//
//  PresentationLayerDelegate.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

internal protocol PresentationLayerDelegate {
    /**
     * Sets the file for a particular file id on the holders side.
     *
     * @param id   the file id of the data
     * @param data bytes of the file.
     * @return boolean informing the caller if the file was successfully set.
     */
    func getLocalfile(id: ElementaryFileID) -> ApduFile?
    
    func getAppId() -> DedicatedFileID
    func isFileAllowed(file: ElementaryFileID) -> Bool
    
    /// Informs the delegate when got an exception when sending has failed.
    func onSendFailure(exception: Error)//This can be a IO Exception (lost connection) or invalid APDU.
    /// Informs the delegate when we've received an invalid apdu
    func onReceiveInvalidApdu(exception: Error)
}
