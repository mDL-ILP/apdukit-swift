//
//  ApplicationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

//class ApplicationLayer: PresentationLayerDelegate {
//    func getLocalfile(id: ElementaryFileID) -> ApduFile {
//        
//    }
//    
//    func getAppId() -> DedicatedFileID {
//        ExampleApp.instance.ValidDF_NormalLength1
//    }
//    
//    func isFileAllowed(file: ElementaryFileID) -> Bool {
//        return true
//    }
//    
//    func onSendFailure(exception: Error) {
//        
//    }
//    
//    func onReceiveInvalidApdu(exception: Error) {
//        
//    }
//    
//    /**
//     * Routes call to right EF read. If short it'll use the short id otherwise it'll use the normal.
//     * @param fileID
//     * @return
//     */
//    public func read(EF fileID: ElementaryFileID) -> Promise<[byte]> {
//        var data: [byte] = []
//        return Promise<[byte]>(value: data)
//    }
//    
//}
