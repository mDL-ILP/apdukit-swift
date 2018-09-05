// MARK: - Mocks generated from file: apduKit/interpreter/transportLayer/TransportLayerDelegate.swift at 2018-09-05 15:11:08 +0000

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

    

    

    
    // ["name": "onReceive", "returnSignature": " throws", "fullyQualifiedName": "onReceive(data: [byte]) throws", "parameterSignature": "data: [byte]", "parameterSignatureWithoutNames": "data: [byte]", "inputTypes": "[byte]", "isThrowing": true, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "data", "call": "data: data", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("data"), name: "data", type: "[byte]", range: CountableRange(217..<229), nameRange: CountableRange(217..<221))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ProtocolStubNoReturnThrowingFunction"]
     func onReceive(data: [byte])  throws {
        
            return try cuckoo_manager.callThrows("onReceive(data: [byte]) throws",
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
	    
	    
	    func onReceive<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<([byte])> where M1.MatchedType == [byte] {
	        let matchers: [Cuckoo.ParameterMatcher<([byte])>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerDelegate.self, method: "onReceive(data: [byte]) throws", parameterMatchers: matchers))
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
	        return cuckoo_manager.verify("onReceive(data: [byte]) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class TransportLayerDelegateStub: TransportLayerDelegate {
    

    

    
     func onReceive(data: [byte])  throws {
        return DefaultValueRegistry.defaultValue(for: Void.self)
    }
    
}


// MARK: - Mocks generated from file: apduKit/interpreter/transportLayer/TransportLayerSimulator.swift at 2018-09-05 15:11:08 +0000

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
    
    // ["name": "externalMockTransportLayer", "stubType": "ClassToBeStubbedProperty", "@type": "InstanceVariable", "type": "TransportLayer?", "isReadOnly": false, "accessibility": ""]
     override var externalMockTransportLayer: TransportLayer? {
        get {
            
            return cuckoo_manager.getter("externalMockTransportLayer", superclassCall: super.externalMockTransportLayer)
            
        }
        
        set {
            
            cuckoo_manager.setter("externalMockTransportLayer", value: newValue, superclassCall: super.externalMockTransportLayer = newValue)
            
        }
        
    }
    

    

    
    // ["name": "connect", "returnSignature": "", "fullyQualifiedName": "connect(transportLayer: TransportLayer)", "parameterSignature": "transportLayer: TransportLayer", "parameterSignatureWithoutNames": "transportLayer: TransportLayer", "inputTypes": "TransportLayer", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "transportLayer", "call": "transportLayer: transportLayer", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("transportLayer"), name: "transportLayer", type: "TransportLayer", range: CountableRange(330..<360), nameRange: CountableRange(330..<344))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnFunction"]
     override func connect(transportLayer: TransportLayer)  {
        
            return cuckoo_manager.call("connect(transportLayer: TransportLayer)",
                parameters: (transportLayer),
                superclassCall:
                    
                    super.connect(transportLayer: transportLayer)
                    )
        
    }
    
    // ["name": "write", "returnSignature": " throws", "fullyQualifiedName": "write(data: [byte]) throws", "parameterSignature": "data: [byte]", "parameterSignatureWithoutNames": "data: [byte]", "inputTypes": "[byte]", "isThrowing": true, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "data", "call": "data: data", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("data"), name: "data", type: "[byte]", range: CountableRange(447..<459), nameRange: CountableRange(447..<451))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnThrowingFunction"]
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
    
    // ["name": "set", "returnSignature": "", "fullyQualifiedName": "set(delegate: TransportLayerDelegate)", "parameterSignature": "delegate: TransportLayerDelegate", "parameterSignatureWithoutNames": "delegate: TransportLayerDelegate", "inputTypes": "TransportLayerDelegate", "isThrowing": false, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "delegate", "call": "delegate: delegate", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("delegate"), name: "delegate", type: "TransportLayerDelegate", range: CountableRange(763..<795), nameRange: CountableRange(763..<771))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnFunction"]
     override func set(delegate: TransportLayerDelegate)  {
        
            return cuckoo_manager.call("set(delegate: TransportLayerDelegate)",
                parameters: (delegate),
                superclassCall:
                    
                    super.set(delegate: delegate)
                    )
        
    }
    
    // ["name": "onReceive", "returnSignature": " throws", "fullyQualifiedName": "onReceive(data: [byte]) throws", "parameterSignature": "data: [byte]", "parameterSignatureWithoutNames": "data: [byte]", "inputTypes": "[byte]", "isThrowing": true, "isInit": false, "isOverriding": true, "hasClosureParams": false, "@type": "ClassMethod", "accessibility": "", "parameterNames": "data", "call": "data: data", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("data"), name: "data", type: "[byte]", range: CountableRange(862..<874), nameRange: CountableRange(862..<866))], "returnType": "Void", "isOptional": false, "stubFunction": "Cuckoo.ClassStubNoReturnThrowingFunction"]
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
	    
	    var externalMockTransportLayer: Cuckoo.ClassToBeStubbedProperty<MockTransportLayerSimulator, TransportLayer?> {
	        return .init(manager: cuckoo_manager, name: "externalMockTransportLayer")
	    }
	    
	    
	    func connect<M1: Cuckoo.Matchable>(transportLayer: M1) -> Cuckoo.ClassStubNoReturnFunction<(TransportLayer)> where M1.MatchedType == TransportLayer {
	        let matchers: [Cuckoo.ParameterMatcher<(TransportLayer)>] = [wrap(matchable: transportLayer) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockTransportLayerSimulator.self, method: "connect(transportLayer: TransportLayer)", parameterMatchers: matchers))
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
	    
	    var externalMockTransportLayer: Cuckoo.VerifyProperty<TransportLayer?> {
	        return .init(manager: cuckoo_manager, name: "externalMockTransportLayer", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func connect<M1: Cuckoo.Matchable>(transportLayer: M1) -> Cuckoo.__DoNotUse<Void> where M1.MatchedType == TransportLayer {
	        let matchers: [Cuckoo.ParameterMatcher<(TransportLayer)>] = [wrap(matchable: transportLayer) { $0 }]
	        return cuckoo_manager.verify("connect(transportLayer: TransportLayer)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
     override var externalMockTransportLayer: TransportLayer? {
        get {
            return DefaultValueRegistry.defaultValue(for: (TransportLayer?).self)
        }
        
        set { }
        
    }
    

    

    
     override func connect(transportLayer: TransportLayer)  {
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

