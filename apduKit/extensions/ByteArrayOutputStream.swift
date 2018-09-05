//
//  ByteArrayOutputStream.swift
//  apduKit
//  Allows for similar behaviour as the ByteArrayOutputStream Java counterpart.
//  Please see java.io.ByteArrayOutputStream
//  Created by Iain Munro on 28/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

class ByteArrayOutputStream /*: OutputStream*/ {
    /**
     * The buffer where data is stored.
     */
    private(set) var buffer: [byte]
    
    init(minCapacity: Int = 1024) {
        self.buffer = [byte]()
        self.buffer.reserveCapacity(minCapacity)//Grow the buf array to speed the writes up
    }
    
    /**
     * Writes the specified byte to this byte array output stream.
     *
     * @param   b   the byte to be written.
     */
    func write(byte: byte) {
        self.buffer.append(byte)
    }
    
    /**
     * Writes the specified bytes to this byte array output stream.
     *
     * @param   b   the byte to be written.
     */
    func write(bytes: [byte]) {
        self.buffer.append(contentsOf: bytes)
    }
    
}
