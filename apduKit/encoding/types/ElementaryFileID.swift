//
//  ElementaryFileID.swift
//  apduKit
//  ElementaryFileID, identifying a certain file (datagroup). ISO 7816-4, Section 5 - Basic Organizations
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
class ElementaryFileID: FileID, Equatable {
    private(set) var shortIdentifier: byte?
    private(set) var normalIdentifier: [byte]?
    
    init(shortIdentifier: byte? = nil, normalIdentifier: short) throws {
        self.shortIdentifier = shortIdentifier
        self.normalIdentifier = ConversionUtils.fromShortToBytes(normalIdentifier)
        try self.validate()
    }
    
    init(shortIdentifier: byte) throws {
        self.shortIdentifier = shortIdentifier
        self.normalIdentifier = nil
        try self.validate()
    }
    
    func getShortIdentifier() throws -> byte? {
        return shortIdentifier
    }
    
    func isShortIDAvailable() -> Bool {
        return shortIdentifier != nil
    }
    
    func getShortIDValueAsAShort() -> short? {
        guard let shortIdentifier = self.shortIdentifier else { return nil }
        return try? ConversionUtils.fromBytesToShort([shortIdentifier])
    }
    
    func getValue() -> [byte]? {
        return self.normalIdentifier
    }
    
    func getNormalIDValueAsAShort() -> short? {
        guard let normalIdentifier = self.normalIdentifier else { return nil }
        return try? ConversionUtils.fromBytesToShort(normalIdentifier);
    }
    
    func validate() throws {
        if self.shortIdentifier == nil && self.normalIdentifier == nil {
            throw ApduErrors.InvalidElementaryFileId(description: "No identifier is available")
        }
        //Checks for the short file identifier
        if let shortIdentifier = self.shortIdentifier {
            if !ConversionUtils.areTheFirstThreeBitsZero(value: shortIdentifier) {
                throw ApduErrors.InvalidElementaryFileId(description: "No identifier is available")
            }
        }
    }
    
    //Like java: public boolean equals(Object obj)
    static func == (lhs: ElementaryFileID, rhs: ElementaryFileID) -> Bool {
        if lhs.shortIdentifier == rhs.shortIdentifier {
            return true
        }
        guard let rNormal = rhs.normalIdentifier else { return false }
        guard let lNormal = lhs.normalIdentifier else { return false }
        if lNormal.elementsEqual(rNormal) {
            return true
        }
        return false
    }
}
