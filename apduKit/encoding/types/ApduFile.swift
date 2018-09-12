//
//  ApduFile.swift
//  apduKit
//
//  Created by Iain Munro on 27/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
public class ApduFile {
    
    private(set) var info: TLVInfo
    private(set) var declaredSize: short = 0
    private(set) var data: ByteArrayOutputStream!
    
    init(data: [byte]) throws {
        if data.count < 2 {
            throw ApduErrors.InvalidApduException(description: "Needs at least one byte for the tag. Another for the minimal length size which can be one byte.")
        }
        self.info = try TLVInfo(data: data)
        try computeDeclaredSize()
        
        self.data = ByteArrayOutputStream(minCapacity: int(self.getDeclaredSize()))
        self.data.write(bytes: data)
        if getCurrentSize() > getDeclaredSize() {
            throw ApduErrors.InvalidApduFileException(description: "Invalid TLV. The current size is larger than the declared size.")
        }
        if remainingBytes() < 0 {
            throw ApduErrors.InvalidApduFileException(description: "Invalid TLV. Remaining bytes is negative.")
        }
    }
    
    
    public func isComplete() -> Bool {
        return getCurrentSize() >= getDeclaredSize()
    }
    
    public func getTag() -> byte {
        return self.data.buffer[0]
    }
    
    private func computeDeclaredSize() throws {
        self.declaredSize = short(self.info.length) + short(self.info.dataOffset)
        if self.declaredSize <= 0 {
            throw ApduErrors.InvalidApduFileException(description: "Total size is 0")
        }
    }
    
    public func getData() -> [byte] {
        
        return data.buffer
    }
    
    public func getDeclaredSize() -> short {
        return self.declaredSize
    }
    
    public func getCurrentSize() -> short {
        return short(data.buffer.count)
    }
    
    public func remainingBytes() -> short {
        if isComplete() {
            return 0
        }
        return getDeclaredSize() - getCurrentSize()
    }
}
