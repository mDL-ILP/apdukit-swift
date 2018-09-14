//
//  TestReader.swift
//  apduKitTests
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Foundation

public class TestReader: ReaderApplicationLayer {
    init(presentationLayer: PresentationLayer) {
        super.init(presentationLayer: presentationLayer, appId: ExampleApp.instance.ValidDF_NormalLength1)
    }
    
    public override func onSendFailure(exception: Error) {
        print(exception.localizedDescription)
    }
    
    public override func onReceiveInvalidApdu(exception: Error) {
        print(exception.localizedDescription)
    }
}
