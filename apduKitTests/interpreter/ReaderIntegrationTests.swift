//
//  ReaderIntegrationTests.swift
//  apduKitTests
//
//  Created by Iain Munro on 13/09/2018.
//  Copyright © 2018 UL-TS. All rights reserved.
//

import XCTest
import Promises
import Cuckoo

public class ReaderIntegrationTests: IntegrationTests {

    public func testDisconnected() throws {
        try self.readerTransportLayer.close()
        let p = self.reader.test(file: ExampleApp.instance.ValidEF_NoShortId)
        XCTAssertThrowsError(try p.getValue())
    }
    
    public func testWrongApplication() throws {
        let fileData: [byte] = [01, 02, 03, 07]
        //Set the file on the holder side.
        XCTAssertTrue(try self.holder.setLocalFile(id: ExampleApp.instance.ValidShortIdEF1, data: fileData))
        
        //Change app id
        self.holder.appId = ExampleApp.instance.ValidDF_NormalLength2
        let p = self.reader.read(file: ExampleApp.instance.ValidShortIdEF1)
        XCTAssertThrowsError(try p.getValue())
    }
    
    public func testGetFileWithShortId() throws {
        let fileData: [byte] = [01, 02, 03, 07]
        //Set the file on the holder side.
        XCTAssertTrue(try self.holder.setLocalFile(id: ExampleApp.instance.ValidShortIdEF1, data: fileData))
        
        let p = self.reader.read(file: ExampleApp.instance.ValidShortIdEF1)
        XCTAssertEqual(fileData, try p.getValue())
    }
    
    public func testGetFileWithNormalId() throws {
        let fileData: [byte] = [01, 02, 03, 07]
        //Set the file on the holder side.
        XCTAssertTrue(try self.holder.setLocalFile(id: ExampleApp.instance.ValidNormalIdEF, data: fileData))
        
        let p = self.reader.read(file: ExampleApp.instance.ValidNormalIdEF)
        XCTAssertEqual(fileData, try p.getValue())
    }
    
    public func testGetFileUsingShortIdDoesNotExist() throws {
        let p = self.reader.read(file: ExampleApp.instance.ValidShortIdEF1)
        XCTAssertThrowsError(try p.getValue())
    }
    
    public func testGetFileUsingNormalIdDoesNotExist() throws {
        let p = self.reader.read(file: ExampleApp.instance.ValidNormalIdEF)
        XCTAssertThrowsError(try p.getValue())
    }
    
    public func testGetLargeFileUsingNormalId() throws {
        let fileData: [byte] = ExampleApp.instance.DatagroupE
        //Set the file on the holder side.
        XCTAssertTrue(try self.holder.setLocalFile(id: ExampleApp.instance.ValidNormalIdEF, data: fileData))
        
        let p = self.reader.read(file: ExampleApp.instance.ValidNormalIdEF)
        XCTAssertEqual(fileData, try p.getValue())
    }
    
    public func testOutOfSequence() throws {
        let message = SelectCommand().set(fileID: ExampleApp.instance.ValidDF_NormalLength2).set(fileControlInfo: .NOFCIReturn)
        readerSessionLayer.send(command: message)//Send once.
        let p2 = readerSessionLayer.send(command: message).then(on: DispatchQueue.apduPromises) { (e) in//Double send. Out of sequence!!
            XCTFail("ou cannot send two messages while we have one open request standing")
        }
        XCTAssertThrowsError(try p2.getValue())
    }
    
//    public func testInvalidOnReceiveWithOpenRequest() throws {
//        class TestTransportLayer: TransportLayerSimulator {
//            override func write(data: [byte]) throws {}
//            override func close() throws {}
//            override func set(delegate: TransportLayerDelegate) {}
//        }
//        let a = TestTransportLayer()
//        self.readerTransportLayer.connect(transportLayer: a)
//
//        let reader = MockReaderApplicationLayer(
//            presentationLayer: self.readerPresentationLayer,
//            appId: ExampleApp.instance.ValidDF_NormalLength2
//        ).withEnabledSuperclassSpy()
//        self.reader = reader
//        self.readerPresentationLayer.set(delegate: self.reader)
//
//        stub(reader) { (readerStub) in
////            when(readerStub.onReceiveInvalidApdu(exception: any())).thenDoNothing()
//            //Do a select command.
//            let message = SelectCommand().set(fileID: ExampleApp.instance.ValidDF_NormalLength2).set(fileControlInfo: .NOFCIReturn)
//            let p = readerSessionLayer.send(command: message)
//
//            //Then call the onReceive function with an invalid apdu.
//            readerSessionLayer.onReceive(data: [0, 0, 1])
//
//            //Verify that the error was reported all the way back to the application
//            verify(reader, atLeastOnce()).onReceiveInvalidApdu(exception: any())
//            do {
//                XCTAssertThrowsError(try p.getValue())
//            }catch let e {}
//        }
//
//    }
    
//    public func testInvalidOnReceiveWithoutARequest() throws {
//        //Mock transport layer so it doesn't actually write.
//        let transportLayer = MockTransportLayerSimulator().withEnabledSuperclassSpy()
//        self.readerTransportLayer = transportLayer
//        setupSessionLayers()
//
//        let reader = MockReaderApplicationLayer(presentationLayer: self.readerPresentationLayer, appId: ExampleApp.instance.ValidDF_NormalLength2).withEnabledSuperclassSpy()
//        self.reader = reader
//        self.readerPresentationLayer.set(delegate: self.reader)
//
//        stub(reader) { (readerStub) in
//            stub(transportLayer) { (transportLayerStub) in
//
//                when(readerStub.onReceiveInvalidApdu(exception: any())).thenDoNothing()
//
//                //Then call the onReceive function with an invalid apdu.
//                readerSessionLayer.onReceive(data: [0, 0, 1])
//
//                //Verify that the error was reported all the way back to the application
//                verify(reader, atLeastOnce()).onReceiveInvalidApdu(exception: any())
//            }
//        }
//    }
    
    public func testConcurrentGetFile() throws {
        let expected: [byte] = [01, 02, 03, 07]
        try holder.setLocalFile(id: ExampleApp.instance.ValidShortIdEF1, data: expected)
        let expection = self.expectation(description: "thread done")
        //One thread asking for a file
        DispatchQueue.global().async {
            do {
                let p = self.reader.read(file: ExampleApp.instance.ValidShortIdEF1)
                XCTAssertEqual(expected, try p.getValue())
                expection.fulfill()
            }catch let e {
                XCTFail(e.localizedDescription)
            }
        }
        
        //Main thread asking for a file
        let p = self.reader.read(file: ExampleApp.instance.ValidShortIdEF1)
        XCTAssertEqual(expected, try p.getValue())
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
