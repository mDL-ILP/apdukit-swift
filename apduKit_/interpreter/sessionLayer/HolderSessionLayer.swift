//
//  HolderSessionLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

/**
 * The server session layer handles sending and receiving apdu messages. It decodes incoming bytes into Apdu objects and then calls the appropriate delegate message handle method.
 */
internal class HolderSessionLayer: SessionLayer {
    private let transportLayer: TransportLayer
    private var delegate: SessionLayerDelegate?
    
    init(transportLayer: TransportLayer) {
        self.transportLayer = transportLayer
        self.transportLayer.set(delegate: self)
    }
    
    internal func send(command: CommandApdu) -> Promise<ResponseApdu> {
        return Promise(on: DispatchQueue.apduPromises) { () -> ResponseApdu in
            throw InterpeterErrors.Exception(message: "Following the APDU specification a holder cannot start a send")
        }
    }
    
    internal func set(delegate: SessionLayerDelegate) {
        self.delegate = delegate
    }
    
    private func send(response: ResponseApdu?) {
        var reply = response
        if reply == nil {
            reply = ResponseApdu().set(statusCode: .ERROR_UNKNOWN)
        }
        do {
            try self.transportLayer.write(data: try reply!.toBytes().buffer)
        }catch let e {
            self.delegate?.onSendFailure(exception: e)
            send(response: nil)//Send unknown error back.
        }
    }
    
    internal func onReceive(data: [byte]) {
        var response: ResponseApdu? = nil
        do {
            let request = try CommandApdu.fromBytes(data)
            switch request {
            case let command as SelectCommand:
                response = self.delegate?.receivedSelectCommand(command: command)
                break
            case let command as ReadBinaryCommand:
                response = self.delegate?.receivedReadCommand(command: command)
                break
            default:
                break
            }
        }catch let e {
            self.delegate?.onReceiveInvalidApdu(exception: e)
        }
        send(response: response)
    }
}
