//
//  DedicatedFileID.swift
//  apduKit
//  
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
public class DedicatedFileID: FileID, Equatable {
    private(set) var value: [UInt8]
    
    init(_ value: [UInt8]) {
        self.value = value
    }
    
    public static func == (lhs: DedicatedFileID, rhs: DedicatedFileID) -> Bool {
        return lhs.value.elementsEqual(rhs.value)
    }
    
    public func getValue() -> [byte]? {
        return self.value
    }
    
}
