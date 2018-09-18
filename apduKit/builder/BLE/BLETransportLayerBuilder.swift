//
//  BLETransportLayer.swift
//  apduKit
//
//  Created by Iain Munro on 17/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import BluetoothKit_fork
import Promises

public class BLETransportLayerBuilder: BKAvailabilityObserver, TransportLayerBuilder{
    private let profile: TransportProfile
    private let serviceUUID: UUID
    private let characteristicUUID: UUID
    
    let central = BKCentral()
    let peripheral = BKPeripheral()
    
    public var delegate: TransportLayerBuilderDelegate?
    public var openBuildRequest: Promise<TransportLayer>?
    
    public init(
        profile: TransportProfile,
        serviceUUID: UUID,
        characteristicUUID: UUID,
        delegate: TransportLayerBuilderDelegate? = nil
    ) {
        self.profile = profile
        self.serviceUUID = serviceUUID
        self.characteristicUUID = characteristicUUID
        self.delegate = delegate
        
        do {
            try setupPeripheral()
        } catch let e {
            print(e.localizedDescription)
            //Throw if reader.
        }
        do {
            try setupCentral()
        } catch let e {
            print(e.localizedDescription)
            //Throw if holder.
        }
    }
    
    private func setupCentral() throws {
        self.central.delegate = self
        self.central.addAvailabilityObserver(self)
        let configuration = BKConfiguration(
            dataServiceUUID: self.serviceUUID,
            dataServiceCharacteristicUUID: self.characteristicUUID,
            chunkingEnabled: false
        )
        try self.central.startWithConfiguration(configuration)
    }
    
    private func setupPeripheral() throws {
        self.peripheral.delegate = self
        let configuration = BKPeripheralConfiguration(
            dataServiceUUID: self.serviceUUID,
            dataServiceCharacteristicUUID: self.characteristicUUID,
            localName: UIDevice.current.name,
            chunkingEnabled: false
        )
        try self.peripheral.startWithConfiguration(configuration)
    }
    
    public func build() -> Promise<TransportLayer> {
        if self.openBuildRequest != nil {
            return self.openBuildRequest!
        }
        self.openBuildRequest = Promise<TransportLayer>.pending()
        return self.openBuildRequest!
    }
}

extension BLETransportLayerBuilder : BKCentralDelegate {
    private func scan() {
        self.central.scanContinuouslyWithChangeHandler(self.ScanChanged, stateHandler: { newState in
            print(newState)
        }, duration: 3, inBetweenDelay: 3, errorHandler: { error in
            print(error)
        })
    }
    
    //Connect to all peripheral we find.
    private func ScanChanged(_ changes: [BKDiscoveriesChange], _ discoveries: [BKDiscovery]) {
        for discovery in discoveries {
            //Collision identifier
            
            self.central.connect(remotePeripheral: discovery.remotePeripheral) { remotePeripheral, error in
                if error != nil {
                    //print(error)
                    return
                }
                self.central(self.central, remotePeripheralDidConnect: remotePeripheral)
            }
        }
    }
    
    /*
     var state = TransportLayerBuilderState.unavailable
     if peripheral.state == .poweredOn {
     state = .available
     }
     self.delegate?.onChanged(state: state)
     */
    public func availabilityObserver(_ availabilityObservable: BKAvailabilityObservable, availabilityDidChange availability: BKAvailability) {
        switch availability {
        case .available:
            scan()
        default:
            print("report this back to the user? \(availability)")
        }
    }
    
    public func availabilityObserver(_ availabilityObservable: BKAvailabilityObservable, unavailabilityCauseDidChange unavailabilityCause: BKUnavailabilityCause) {
        print("c")
    }
    
    public func central(_ central: BKCentral, remotePeripheralDidConnect remotePeripheral: BKRemotePeripheral) {
        print("central::connected")
        let device = BluetoothDevice(peer: central, remotePeer: remotePeripheral)
        let transport = BLETransportLayer(peer: device)
        openBuildRequest?.fulfill(transport)
    }
    
    public func central(_ central: BKCentral, remotePeripheralDidDisconnect remotePeripheral: BKRemotePeripheral) {
        print("central::disconnected")
        //Inform delegate of this disaster
    }
}

extension BLETransportLayerBuilder : BKPeripheralDelegate {
    
    public func peripheral(_ peripheral: BKPeripheral, remoteCentralDidConnect remoteCentral: BKRemoteCentral) {
        print("peripheral::connected")
        let device = BluetoothDevice(peer: peripheral, remotePeer: remoteCentral)
        let transport = BLETransportLayer(peer: device)
        //TODO: Check collision identifier
        openBuildRequest?.fulfill(transport)
    }
    
    public func peripheral(_ peripheral: BKPeripheral, remoteCentralDidDisconnect remoteCentral: BKRemoteCentral) {
        print("peripheral::disconnected")
        //Inform delegate of this disaster
    }
    
}
