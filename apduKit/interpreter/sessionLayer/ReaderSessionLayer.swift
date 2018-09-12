//
//  ReaderSessionLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promise

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
    }
    
    private func commandToBytes(input: CommandApdu) -> Promise<[byte]> {
        return Promise<[byte]>(work: { fulfill, reject in
            do {
                fulfill(try input.toBytes().buffer)
            } catch let e {
                reject(e)
            }
        })
    }
    
    public func send(command: CommandApdu) -> Promise<ResponseApdu> {
        if openRequestLock.wait(timeout: DispatchTime.now()) == DispatchTimeoutResult.timedOut {
            return Promise<ResponseApdu>(error: InterpeterErrors.OutOfSequenceException())
        }
        let p = commandToBytes(input: command).then(self.sendBytes)
        p.always {
            self.openRequestLock.signal()
        }
        return p
    }
    
    public func sendBytes(data: [byte]) -> Promise<ResponseApdu> {
        let p = Promise<ResponseApdu>(work: { fulfill, reject in
            do {
                try self.transportLayer.write(data: data)
            } catch let e {
                reject(e)
            }
        })
        openRequest = p
        p.always {
            self.openRequest = nil
        }
        return p
    }
    
    public func setDelegate(delegate: SessionLayerDelegate) {
        self.delegate = delegate
    }
    
    public func onReceive(data: [byte]) {
        guard let openRequest = self.openRequest else {
            self.delegate?.onReceiveInvalidApdu(exception: ApduErrors.InvalidApduException(description: "received unwanted response"))
            return
        }
        do {
            let response = try ResponseApdu.fromBytes(data)
            openRequest.fulfill(response)
        } catch let e {
            openRequest.reject(e)
        }
    }
    
    
}
