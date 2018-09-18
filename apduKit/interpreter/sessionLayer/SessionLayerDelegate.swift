//
//  SessionLayerDelegate.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

internal protocol SessionLayerDelegate {
    /// Responds with the binary data of that EF file.
    func receivedReadCommand(command: ReadBinaryCommand) -> ResponseApdu
    /// Responds with the appropriate status code.
    func receivedSelectCommand(command: SelectCommand) -> ResponseApdu
    
    /// Informs the delegate when got an exception when sending has failed.
    func onSendFailure(exception: Error)//This can be a IO Exception (lost connection) or invalid APDU.
    /// Informs the delegate when we've received an invalid apdu
    func onReceiveInvalidApdu(exception: Error)
}
