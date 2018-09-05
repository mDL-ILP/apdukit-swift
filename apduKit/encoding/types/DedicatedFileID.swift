//
//  DedicatedFileID.swift
//  apduKit
//  
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
class DedicatedFileID: FileID, Equatable {
    private(set) var value: [UInt8]
    
    init(_ value: [UInt8]) {
        self.value = value
    }
    
    static func == (lhs: DedicatedFileID, rhs: DedicatedFileID) -> Bool {
        return lhs.value.elementsEqual(rhs.value)
    }
    
    func getValue() -> [byte]? {
        return self.value
    }
    
}
