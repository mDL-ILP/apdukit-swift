//
//  ReaderSessionLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promises

/**
 * The client session layer handles sending and receiving APDU messages. It also allows for sending APDU commands and keeping track of this open request. Then fulfilling the promise upon receiving data.
 */
public class ReaderSessionLayer: SessionLayer {
    
    private let transportLayer: TransportLayer
    private var delegate: SessionLayerDelegate?
    
    private let openRequestLock = DispatchSemaphore(value: 1)
    private var openRequest: Promise<ResponseApdu>?
    
    init(transportLayer: TransportLayer) {
        self.transportLayer = transportLayer
        self.transportLayer.set(delegate: self)
    }
    
    private func commandToBytes(input: CommandApdu) -> Promise<[byte]> {
        return Promise(on: DispatchQueue.apduPromises) { () -> [byte] in
            let payload = try input.toBytes().buffer
            return payload
        }
    }
    
    public func send(command: CommandApdu) -> Promise<ResponseApdu> {
        if openRequestLock.wait(timeout: DispatchTime.now()) == DispatchTimeoutResult.timedOut {
            return Promise(on: DispatchQueue.apduPromises) { () -> ResponseApdu in
                throw InterpeterErrors.OutOfSequenceException()
            }
        }
        return commandToBytes(input: command)
            .then(on: DispatchQueue.apduPromises, self.sendBytes)
            .always(on: DispatchQueue.apduPromises, {
                self.openRequestLock.signal()
            })
    }
    
    public func sendBytes(data: [byte]) -> Promise<ResponseApdu> {
        let p = Promise<ResponseApdu>(on: DispatchQueue.apduPromises) { (fulfill, reject) in
            try self.transportLayer.write(data: data)
        }
        openRequest = p
        p.always(on: DispatchQueue.apduPromises, {
            self.openRequest = nil
        })
        return p
    }
    
    public func set(delegate: SessionLayerDelegate) {
        self.delegate = delegate
    }
    
    public func onReceive(data: [byte]) {
        //We received an unwanted response?
        guard let openRequest = self.openRequest else {
            self.delegate?.onReceiveInvalidApdu(exception: ApduErrors.InvalidApduException(description: "received unwanted response"))
            return
        }
        do {
            let response = try ResponseApdu.fromBytes(data)
            openRequest.fulfill(response)
        } catch let e {
            openRequest.reject(e)
            self.delegate?.onReceiveInvalidApdu(exception: e)
        }
    }
    
    
}
