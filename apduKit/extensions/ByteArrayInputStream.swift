//
//  ByteArrayInputStream.swift
//  apduKit
//  Allows for similar behaviour as the ByteArrayInputStream Java counterpart.
//  Please see java.io.ByteArrayInputStream
//  Created by Iain Munro on 28/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

internal class ByteArrayInputStream /*: InputStream*/ {
    enum StreamErrors: Error {
        case OutOfBytes()
    }
    
    /**
     * An array of bytes that was provided
     */
    private var buf: [byte]
    
    /**
     * The index of the next character to read from the input stream buffer.
     * and not larger than the value of <code>count</code>.
     * The next byte to be read from the input stream buffer
     * will be <code>buf[pos]</code>.
     */
    private var pos = 0
    
    init(bytes buf: [byte]) {
        self.buf = buf
    }
    
    /**
     * Reads the next byte of data from this input stream. The value
     * byte is returned as an <code>int</code> in the range
     * <code>0</code> to <code>255</code>. If no byte is available
     * because the end of the stream has been reached, the value
     * <code>nil</code> is returned.
     * <p>å
     *
     * @return  the next byte of data, or <code>-1</code> if the end of the
     *          stream has been reached.
     */
    func readByte() -> byte? {
        if available() <= 0 {
            return nil
        }
        let result = buf[self.pos]
        pos += 1
        return result
    }
    
    /**
     * Reads the next bytes of data from this input stream. The value
     * of byte array. The function will throw an exception if the callee
     * asked for too many bytes than that are available in the stream.
     * so it is wise to call available() first to find out how many bytes
     * can be asked.
     * @return  the next byte of data, or <code>-1</code> if the end of the
     *          stream has been reached.
     */
    func readBytes(size: Int) throws -> [byte] {
        var result = Array<byte>.init(repeating: 0, count: size)
        for i in 0..<size {
            if let value = self.readByte() {
                result[i] = value
            } else {
                throw StreamErrors.OutOfBytes()
            }
        }
        return result
    }
    
    /**
     * Returns the number of remaining bytes that can be read (or skipped over)
     * from this input stream.
     */
    func available() -> Int {
        return buf.count - pos
    }
    
    /**
     * Skips n bytes of input from this input stream. Fewer
     * bytes might be skipped if the end of the input stream is reached.
     *
     * @param   n   the number of bytes to be skipped.
     */
    func skip(_ n: Int) {
        self.pos += n
        if self.pos > available() {
            self.pos = available()
        }
    }
    
    /**
     * Resets the buffer to the marked position.  The marked position
     * is 0 unless another position was marked or an offset was specified
     * in the constructor.
     */
    func reset() {
        self.pos = 0
    }
    
}
