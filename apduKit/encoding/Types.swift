//
//  Types.swift
//  apduKit
//  Make type defs so they are named the same as in the Java version and if there are any mistakes to make it easy to correct
//  Created by Iain Munro on 24/08/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public typealias int = CInt
public typealias byte = UInt8//In java its a signed int8. Meaning that some values overflowing a UInt8 are negative in Java.
public typealias short = u_short
