//
//  PresentationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation
import Promise

public protocol PresentationLayer: SessionLayerDelegate {
    func select(DF fileID: DedicatedFileID) -> Promise<()>
    func select(EF fileID: ElementaryFileID) -> Promise<()>
    func read(EF fileID: ElementaryFileID) -> Promise<[byte]>
    func set(delegate: PresentationLayerDelegate)
}
