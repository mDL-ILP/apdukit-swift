// MARK: - Mocks generated from file: apduKit/interpreter/applicationLayer/ReaderApplicationLayer.swift at 2018-09-17 12:54:17 +0000

//
//  ReaderApplicationLayer.swift
//  apduKit
//
//  Created by Iain Munro on 12/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Cuckoo
@testable import apduKit

import Foundation
import Promises

class MockReaderApplicationLayer: ReaderApplicationLayer, Cuckoo.ClassMock {
    typealias MocksType = ReaderApplicationLayer
    typealias Stubbing = __StubbingProxy_ReaderApplicationLayer
    typealias Verification = __VerificationProxy_ReaderApplicationLayer
    let cuckoo_manager = Cuckoo.MockManager(hasParent: true)

    
    // ["name": "appId", "stubType": "ClassToBeStubbedProperty", "@type": "InstanceVariable", "type": "DedicatedFileID", "isReadOnly": false, "accessibility": ""]
     override var appId: DedicatedFileID {
        get {
            
            return cuckoo_manager.getter("appId", superclassCall: super.appId)
            
        }
        
        set {
            
            cuckoo_manager.setter("appId", value: newValue, superclassCall: super.appId = newValue)
            
        }
        
    }
    
    // ["name": "presentationLayer", "stubType": "ClassToBeStubbedProperty", "@type": "InstanceVariable", "type": "PresentationLayer", "isReadOnly": false, "accessibility": ""]
     override var presentationLayer: PresentationLayer {
        get {
            
            return cuckoo_manager.getter("presentationLayer", superclassCall: super.presentationLayer)
            
        }
        
        set {
            
            cuckoo_manager.setter("presentationLayer", value: newValue, superclassCall: super.presentationLayer = newValue)
            
        }
        
    }
    
    // ["name": "getFileLock", "stubType": "ClassToBeStubbedProperty", "@type": "InstanceVariable", "type": "DispatchSemaphore", "isReadOnly": false, "accessibility": ""]
     override var getFileLock: DispatchSemaphore {
        get {
            
            return cuckoo_manager.getter("getFileLock", superclassCall: super.getFileLock)
            
        }
        
        set {
            
            cuckoo_manager.setter("getFileLock", value: newValue, superclassCall: super.getFileLock = newValue)
            
        }
        
    }
    

    

    
    // ["name": "test", "returnSignature": " -> Promise<()>", "fullyQualifiedName": "test(file: ElementaryFileID) -> Promise<()>", "parameterSignature": "file id: ElementaryFileID", "parameterSignatureWithoutNames": "id: ElementaryFileID", "inputTypes": "ElementaryFileID", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "id", "call": "file: id", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("file"), name: "id", type: "ElementaryFileID", range: CountableRange(705..<730), nameRange: CountableRange(705..<709))], "returnType": "Promise<()>", "isOptional": false, "stubFunction": "Cuckoo.ClassStubFunction"]
     override func test(file id: ElementaryFileID)  -> Promise<()> {
        
            return cuckoo_manager.call("test(file: ElementaryFileID) -> Promise<()>",
                parameters: (id),
                superclassCall:
                    
                    super.test(file: id)
                    )
        
    }
    
    // ["name": "read", "returnSignature": " -> Promise<[byte]>", "fullyQualifiedName": "read(file: ElementaryFileID) -> Promise<[byte]>", "parameterSignature": "file id: ElementaryFileID", "parameterSignatureWithoutNames": "id: ElementaryFileID", "inputTypes": "ElementaryFileID", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "id", "call": "file: id", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("file"), name: "id", type: "ElementaryFileID", range: CountableRange(844..<869), nameRange: CountableRange(844..<848))], "returnType": "Promise<[byte]>", "isOptional": false, "stubFunction": "Cuckoo.ClassStubFunction"]
     override func read(file id: ElementaryFileID)  -> Promise<[byte]> {
        
            return cuckoo_manager.call("read(file: ElementaryFileID) -> Promise<[byte]>",
                parameters: (id),
                superclassCall:
                    
                    super.read(file: id)
                    )
        
    }
    
    // ["name": "getLocalfile", "returnSignature": " -> ApduFile?", "fullyQualifiedName": "getLocalfile(id: ElementaryFileID) -> ApduFile?", "parameterSignature": "id: ElementaryFileID", "parameterSignatureWithoutNames": "id: ElementaryFileID", "inputTypes": "ElementaryFileID", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "id", "call": "id: id", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("id"), name: "id", type: "ElementaryFileID", range: CountableRange(3231..<3251), nameRange: CountableRange(3231..<3233))], "returnType": "Optional<ApduFile>", "isOptional": false, "stubFunction": "Cuckoo.ClassStubFunction"]
     override func getLocalfile(id: ElementaryFileID)  -> ApduFile? {
        
            return cuckoo_manager.call("getLocalfile(id: ElementaryFileID) -> ApduFile?",
                parameters: (id),
                superclassCall:
                    
                    super.getLocalfile(id: id)
                    )
        
    }
    
    // ["name": "getAppId", "returnSignature": " -> DedicatedFileID", "fullyQualifiedName": "getAppId() -> DedicatedFileID", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "DedicatedFileID", "isOptional": false, "stubFunction": "Cuckoo.ClassStubFunction"]
     override func getAppId()  -> DedicatedFileID {
        
            return cuckoo_manager.call("getAppId() -> DedicatedFileID",
                parameters: (),
                superclassCall:
                    
                    super.getAppId()
                    )
        
    }
    
    // ["name": "isFileAllowed", "returnSignature": " -> Bool", "fullyQualifiedName": "isFileAllowed(file: ElementaryFileID) -> Bool", "parameterSignature": "file: ElementaryFileID", "parameterSignatureWithoutNames": "file: ElementaryFileID", "inputTypes": "ElementaryFileID", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "file", "call": "file: file", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("file"), name: "file", type: "ElementaryFileID", range: CountableRange(3417..<3439), nameRange: CountableRange(3417..<3421))], "returnType": "Bool", "isOptional": false, "stubFunction": "Cuckoo.ClassStubFunction"]
     override func isFileAllowed(file: ElementaryFileID)  -> Bool {
        
            return cuckoo_manager.call("isFileAllowed(file: ElementaryFileID) -> Bool",
                parameters: (file),
                superclassCall:
                    
                    super.isFileAllowed(file: file)
                    )
        
    }
    
    // ["name": "onSendFailure", "returnSignature": "", "fullyQualifiedName": "onSendFailure(exception: Error)", "parameterSignature": "exception: Error", "parameterSignatureWithoutNames": "exception: Error", "inputTypes": "Error", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "exception", "call": "exception: exception", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("exception"), name: "exception", type: "Error", range: CountableRange(3538..<3554), nameRange: CountableRange(3538..<3547))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnFunction"]
     override func onSendFailure(exception: Error)  {
        
            return cuckoo_manager.call("onSendFailure(exception: Error)",
                parameters: (exception),
                superclassCall:
                    
                    super.onSendFailure(exception: exception)
                    )
        
    }
    
    // ["name": "onReceiveInvalidApdu", "returnSignature": "", "fullyQualifiedName": "onReceiveInvalidApdu(exception: Error)", "parameterSignature": "exception: Error", "parameterSignatureWithoutNames": "exception: Error", "inputTypes": "Error", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "exception", "call": "exception: exception", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("exception"), name: "exception", type: "Error", range: CountableRange(3670..<3686), nameRange: CountableRange(3670..<3679))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnFunction"]
     override func onReceiveInvalidApdu(exception: Error)  {
        
            return cuckoo_manager.call("onReceiveInvalidApdu(exception: Error)",
                parameters: (exception),
                superclassCall:
                    
                    super.onReceiveInvalidApdu(exception: exception)
                    )
        
    }
    

	struct __StubbingProxy_ReaderApplicationLayer: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    var appId: Cuckoo.ClassToBeStubbedProperty<MockReaderApplicationLayer, DedicatedFileID> {
	        return .init(manager: cuckoo_manager, name: "appId")
	    }
	    
	    var presentationLayer: Cuckoo.ClassToBeStubbedProperty<MockReaderApplicationLayer, PresentationLayer> {
	        return .init(manager: cuckoo_manager, name: "presentationLayer")
	    }
	    
	    var getFileLock: Cuckoo.ClassToBeStubbedProperty<MockReaderApplicationLayer, DispatchSemaphore> {
	        return .init(manager: cuckoo_manager, name: "getFileLock")
	    }
	    
	    
	    func test<M1: Cuckoo.Matchable>(file id: M1) -> Cuckoo.ClassStubFunction<(ElementaryFileID), Promise<()>> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "test(file: ElementaryFileID) -> Promise<()>", parameterMatchers: matchers))
	    }
	    
	    func read<M1: Cuckoo.Matchable>(file id: M1) -> Cuckoo.ClassStubFunction<(ElementaryFileID), Promise<[byte]>> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "read(file: ElementaryFileID) -> Promise<[byte]>", parameterMatchers: matchers))
	    }
	    
	    func getLocalfile<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.ClassStubFunction<(ElementaryFileID), Optional<ApduFile>> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "getLocalfile(id: ElementaryFileID) -> ApduFile?", parameterMatchers: matchers))
	    }
	    
	    func getAppId() -> Cuckoo.ClassStubFunction<(), DedicatedFileID> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "getAppId() -> DedicatedFileID", parameterMatchers: matchers))
	    }
	    
	    func isFileAllowed<M1: Cuckoo.Matchable>(file: M1) -> Cuckoo.ClassStubFunction<(ElementaryFileID), Bool> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: file) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "isFileAllowed(file: ElementaryFileID) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func onSendFailure<M1: Cuckoo.Matchable>(exception: M1) -> Cuckoo.ClassStubNoReturnFunction<(Error)> where M1.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: exception) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "onSendFailure(exception: Error)", parameterMatchers: matchers))
	    }
	    
	    func onReceiveInvalidApdu<M1: Cuckoo.Matchable>(exception: M1) -> Cuckoo.ClassStubNoReturnFunction<(Error)> where M1.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: exception) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockReaderApplicationLayer.self, method: "onReceiveInvalidApdu(exception: Error)", parameterMatchers: matchers))
	    }
	    
	}

	struct __VerificationProxy_ReaderApplicationLayer: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    var appId: Cuckoo.VerifyProperty<DedicatedFileID> {
	        return .init(manager: cuckoo_manager, name: "appId", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    var presentationLayer: Cuckoo.VerifyProperty<PresentationLayer> {
	        return .init(manager: cuckoo_manager, name: "presentationLayer", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    var getFileLock: Cuckoo.VerifyProperty<DispatchSemaphore> {
	        return .init(manager: cuckoo_manager, name: "getFileLock", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func test<M1: Cuckoo.Matchable>(file id: M1) -> Cuckoo.__DoNotUse<Promise<()>> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("test(file: ElementaryFileID) -> Promise<()>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func read<M1: Cuckoo.Matchable>(file id: M1) -> Cuckoo.__DoNotUse<Promise<[byte]>> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("read(file: ElementaryFileID) -> Promise<[byte]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getLocalfile<M1: Cuckoo.Matchable>(id: M1) -> Cuckoo.__DoNotUse<Optional<ApduFile>> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getLocalfile(id: ElementaryFileID) -> ApduFile?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getAppId() -> Cuckoo.__DoNotUse<DedicatedFileID> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getAppId() -> DedicatedFileID", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func isFileAllowed<M1: Cuckoo.Matchable>(file: M1) -> Cuckoo.__DoNotUse<Bool> where M1.MatchedType == ElementaryFileID {
	        let matchers: [Cuckoo.ParameterMatcher<(ElementaryFileID)>] = [wrap(matchable: file) { $0 }]
	        return cuckoo_manager.verify("isFileAllowed(file: ElementaryFileID) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func onSendFailure<M1: Cuckoo.Matchable>(exception: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: exception) { $0 }]
	        return cuckoo_manager.verify("onSendFailure(exception: Error)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func onReceiveInvalidApdu<M1: Cuckoo.Matchable>(exception: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == Error {
	        let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: exception) { $0 }]
	        return cuckoo_manager.verify("onReceiveInvalidApdu(exception: Error)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class ReaderApplicationLayerStub: ReaderApplicationLayer {
    
     override var appId: DedicatedFileID {
        get {
            return DefaultValueRegistry.defaultValue(for: (DedicatedFileID).self)
        }
        
        set { }
        
    }
    
     override var presentationLayer: PresentationLayer {
        get {
            return DefaultValueRegistry.defaultValue(for: (PresentationLayer).self)
        }
        
        set { }
        
    }
    
     override var getFileLock: DispatchSemaphore {
        get {
            return DefaultValueRegistry.defaultValue(for: (DispatchSemaphore).self)
        }
        
        set { }
        
    }
    

    

    
     override func test(file id: ElementaryFileID)  -> Promise<()> {
        return DefaultValueRegistry.defaultValue(for: Promise<()>.self)
    }
    
     override func read(file id: ElementaryFileID)  -> Promise<[byte]> {
        return DefaultValueRegistry.defaultValue(for: Promise<[byte]>.self)
    }
    
     override func getLocalfile(id: ElementaryFileID)  -> ApduFile? {
        return DefaultValueRegistry.defaultValue(for: Optional<ApduFile>.self)
    }
    
     override func getAppId()  -> DedicatedFileID {
        return DefaultValueRegistry.defaultValue(for: DedicatedFileID.self)
    }
    
     override func isFileAllowed(file: ElementaryFileID)  -> Bool {
        return DefaultValueRegistry.defaultValue(for: Bool.self)
    }
    
     override func onSendFailure(exception: Error)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func onReceiveInvalidApdu(exception: Error)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}


// MARK: - Mocks generated from file: apduKit/interpreter/transportLayer/TransportLayerDelegate.swift at 2018-09-17 12:54:17 +0000

//
//  TransportLayerDelegate.swift
//  apduKit
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Cuckoo
@testable import apduKit

import Foundation

class MockTransportLayerDelegate: TransportLayerDelegate, Cuckoo.ProtocolMock {
    typealias MocksType = TransportLayerDelegate
    typealias Stubbing = __StubbingProxy_TransportLayerDelegate
    typealias Verification = __VerificationProxy_TransportLayerDelegate
    let cuckoo_manager = Cuckoo.MockManager(hasParent: false)

    

    

    
    // ["name": "onReceive", "returnSignature": "", "fullyQualifiedName": "onReceive(data: [byte])", "parameterSignature": "data: [byte]", "parameterSignatureWithoutNames": "data: [byte]", "inputTypes": "[byte]", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "public", "parameterNames": "data", "call": "data: data", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("data"), name: "data", type: "[byte]", range: CountableRange(230..<242), nameRange: CountableRange(230..<234))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ProtocolStubNoReturnFunction"]
    public func onReceive(data: [byte])  {
        
            return cuckoo_manager.call("onReceive(data: [byte])",
                parameters: (data),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    )
        
    }
    

	struct __StubbingProxy_TransportLayerDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func onReceive<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([byte])> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerDelegate.self, method: "onReceive(data: [byte])", parameterMatchers: matchers))
	    }
	    
	}

	struct __VerificationProxy_TransportLayerDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func onReceive<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("onReceive(data: [byte])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class TransportLayerDelegateStub: TransportLayerDelegate {
    

    

    
    public func onReceive(data: [byte])  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}


// MARK: - Mocks generated from file: apduKit/interpreter/transportLayer/TransportLayerSimulator.swift at 2018-09-17 12:54:17 +0000

//
//  TransportLayerSimulator.swift
//  apduKit
//
//  Created by Iain Munro on 04/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import Cuckoo
@testable import apduKit

import Foundation

class MockTransportLayerSimulator: TransportLayerSimulator, Cuckoo.ClassMock {
    typealias MocksType = TransportLayerSimulator
    typealias Stubbing = __StubbingProxy_TransportLayerSimulator
    typealias Verification = __VerificationProxy_TransportLayerSimulator
    let cuckoo_manager = Cuckoo.MockManager(hasParent: true)

    
    // ["name": "delegate", "stubType": "ClassToBeStubbedProperty", "@type": "InstanceVariable", "type": "TransportLayerDelegate?", "isReadOnly": false, "accessibility": ""]
     override var delegate: TransportLayerDelegate? {
        get {
            
            return cuckoo_manager.getter("delegate", superclassCall: super.delegate)
            
        }
        
        set {
            
            cuckoo_manager.setter("delegate", value: newValue, superclassCall: super.delegate = newValue)
            
        }
        
    }
    
    // ["name": "externalMockTransportLayer", "stubType": "ClassToBeStubbedProperty", "@type": "InstanceVariable", "type": "TransportLayerSimulator?", "isReadOnly": false, "accessibility": ""]
     override var externalMockTransportLayer: TransportLayerSimulator? {
        get {
            
            return cuckoo_manager.getter("externalMockTransportLayer", superclassCall: super.externalMockTransportLayer)
            
        }
        
        set {
            
            cuckoo_manager.setter("externalMockTransportLayer", value: newValue, superclassCall: super.externalMockTransportLayer = newValue)
            
        }
        
    }
    

    

    
    // ["name": "connect", "returnSignature": "", "fullyQualifiedName": "connect(transportLayer: TransportLayerSimulator)", "parameterSignature": "transportLayer: TransportLayerSimulator", "parameterSignatureWithoutNames": "transportLayer: TransportLayerSimulator", "inputTypes": "TransportLayerSimulator", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "transportLayer", "call": "transportLayer: transportLayer", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("transportLayer"), name: "transportLayer", type: "TransportLayerSimulator", range: CountableRange(358..<397), nameRange: CountableRange(358..<372))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnFunction"]
     override func connect(transportLayer: TransportLayerSimulator)  {
        
            return cuckoo_manager.call("connect(transportLayer: TransportLayerSimulator)",
                parameters: (transportLayer),
                superclassCall:
                    
                    super.connect(transportLayer: transportLayer)
                    )
        
    }
    
    // ["name": "write", "returnSignature": " throws", "fullyQualifiedName": "write(data: [byte]) throws", "parameterSignature": "data: [byte]", "parameterSignatureWithoutNames": "data: [byte]", "inputTypes": "[byte]", "isThrowing": true, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "data", "call": "data: data", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("data"), name: "data", type: "[byte]", range: CountableRange(484..<496), nameRange: CountableRange(484..<488))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnThrowingFunction"]
     override func write(data: [byte])  throws {
        
            return try cuckoo_manager.callThrows("write(data: [byte]) throws",
                parameters: (data),
                superclassCall:
                    
                    super.write(data: data)
                    )
        
    }
    
    // ["name": "close", "returnSignature": " throws", "fullyQualifiedName": "close() throws", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": true, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnThrowingFunction"]
     override func close()  throws {
        
            return try cuckoo_manager.callThrows("close() throws",
                parameters: (),
                superclassCall:
                    
                    super.close()
                    )
        
    }
    
    // ["name": "set", "returnSignature": "", "fullyQualifiedName": "set(delegate: TransportLayerDelegate)", "parameterSignature": "delegate: TransportLayerDelegate", "parameterSignatureWithoutNames": "delegate: TransportLayerDelegate", "inputTypes": "TransportLayerDelegate", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "delegate", "call": "delegate: delegate", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("delegate"), name: "delegate", type: "TransportLayerDelegate", range: CountableRange(800..<832), nameRange: CountableRange(800..<808))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnFunction"]
     override func set(delegate: TransportLayerDelegate)  {
        
            return cuckoo_manager.call("set(delegate: TransportLayerDelegate)",
                parameters: (delegate),
                superclassCall:
                    
                    super.set(delegate: delegate)
                    )
        
    }
    
    // ["name": "onReceive", "returnSignature": " throws", "fullyQualifiedName": "onReceive(data: [byte]) throws", "parameterSignature": "data: [byte]", "parameterSignatureWithoutNames": "data: [byte]", "inputTypes": "[byte]", "isThrowing": true, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "data", "call": "data: data", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("data"), name: "data", type: "[byte]", range: CountableRange(908..<920), nameRange: CountableRange(908..<912))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnThrowingFunction"]
     override func onReceive(data: [byte])  throws {
        
            return try cuckoo_manager.callThrows("onReceive(data: [byte]) throws",
                parameters: (data),
                superclassCall:
                    
                    super.onReceive(data: data)
                    )
        
    }
    

	struct __StubbingProxy_TransportLayerSimulator: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    var delegate: Cuckoo.ClassToBeStubbedProperty<MockTransportLayerSimulator, TransportLayerDelegate?> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    var externalMockTransportLayer: Cuckoo.ClassToBeStubbedProperty<MockTransportLayerSimulator, TransportLayerSimulator?> {
	        return .init(manager: cuckoo_manager, name: "externalMockTransportLayer")
	    }
	    
	    
	    func connect<M1: Cuckoo.Matchable>(transportLayer: M1) -> Cuckoo.ClassStubNoReturnFunction<(TransportLayerSimulator)> where M1.MatchedType == TransportLayerSimulator {
	        let matchers: [Cuckoo.ParameterMatcher<(TransportLayerSimulator)>] = [wrap(matchable: transportLayer) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerSimulator.self, method: "connect(transportLayer: TransportLayerSimulator)", parameterMatchers: matchers))
	    }
	    
	    func write<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<([byte])> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerSimulator.self, method: "write(data: [byte]) throws", parameterMatchers: matchers))
	    }
	    
	    func close() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerSimulator.self, method: "close() throws", parameterMatchers: matchers))
	    }
	    
	    func set<M1: Cuckoo.Matchable>(delegate: M1) -> Cuckoo.ClassStubNoReturnFunction<(TransportLayerDelegate)> where M1.MatchedType == TransportLayerDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<(TransportLayerDelegate)>] = [wrap(matchable: delegate) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerSimulator.self, method: "set(delegate: TransportLayerDelegate)", parameterMatchers: matchers))
	    }
	    
	    func onReceive<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<([byte])> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerSimulator.self, method: "onReceive(data: [byte]) throws", parameterMatchers: matchers))
	    }
	    
	}

	struct __VerificationProxy_TransportLayerSimulator: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    var delegate: Cuckoo.VerifyProperty<TransportLayerDelegate?> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    var externalMockTransportLayer: Cuckoo.VerifyProperty<TransportLayerSimulator?> {
	        return .init(manager: cuckoo_manager, name: "externalMockTransportLayer", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func connect<M1: Cuckoo.Matchable>(transportLayer: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == TransportLayerSimulator {
	        let matchers: [Cuckoo.ParameterMatcher<(TransportLayerSimulator)>] = [wrap(matchable: transportLayer) { $0 }]
	        return cuckoo_manager.verify("connect(transportLayer: TransportLayerSimulator)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func write<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("write(data: [byte]) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func close() -> Cuckoo.__DoNotUse<Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("close() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func set<M1: Cuckoo.Matchable>(delegate: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == TransportLayerDelegate {
	        let matchers: [Cuckoo.ParameterMatcher<(TransportLayerDelegate)>] = [wrap(matchable: delegate) { $0 }]
	        return cuckoo_manager.verify("set(delegate: TransportLayerDelegate)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func onReceive<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("onReceive(data: [byte]) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class TransportLayerSimulatorStub: TransportLayerSimulator {
    
     override var delegate: TransportLayerDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TransportLayerDelegate?).self)
        }
        
        set { }
        
    }
    
     override var externalMockTransportLayer: TransportLayerSimulator? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TransportLayerSimulator?).self)
        }
        
        set { }
        
    }
    

    

    
     override func connect(transportLayer: TransportLayerSimulator)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func write(data: [byte])  throws {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func close()  throws {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func set(delegate: TransportLayerDelegate)  {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
     override func onReceive(data: [byte])  throws {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}

