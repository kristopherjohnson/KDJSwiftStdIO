//
//  KDJSwiftStdIOTests.swift
//  KDJSwiftStdIOTests
//
//  Created by Kristopher Johnson on 7/19/14.
//  Copyright (c) 2014 Kristopher Johnson. All rights reserved.
//

// Unit tests/examples

import XCTest
import KDJSwiftStdIO

class KDJSwiftStdIOTests: XCTestCase {
    
    let testBundle = NSBundle(forClass: KDJSwiftStdIOTests.self)
    
    func pathForTestBundleResource(name: String, ofType: String) -> String {
        return testBundle.pathForResource(name, ofType: ofType)
    }
    
    func test_sequenceOfBytesForFileAtPath() {
        // Content of HelloWorld.txt is "Hello, world!\n"
        let path = pathForTestBundleResource("HelloWorld", ofType: "txt")
        
        var byteCount = 0
        var eofCount = 0
        for byteValue in sequenceOfBytesForFileAtPath(path) {
            if byteValue == EOF {
                ++eofCount
            }
            else {
                ++byteCount
                switch byteCount {
                case 1:
                    XCTAssertEqual(72, byteValue, "should be ASCII code for 'H'")
                case 2:
                    XCTAssertEqual(101, byteValue, "should be ASCII code for 'e'")
                case 14:
                    XCTAssertEqual(10, byteValue, "should be ASCII code for '\\n'")
                default:
                    // OK, we're not checking every single character
                    break;
                }
            }
        }
        XCTAssertEqual(14, byteCount, "should have read 14 bytes")
        XCTAssertEqual(0, eofCount, "should not have read EOF")
    }

    func test_sequenceOfBytesForFileAtPathIntoArray() {
        // Content of HelloWorld.txt is "Hello, world!\n"
        let path = pathForTestBundleResource("HelloWorld", ofType: "txt")
        
        let array = Array<Int32>(sequenceOfBytesForFileAtPath(path))
        
        XCTAssertEqual(14, array.count, "should have read 14 bytes")
        XCTAssertEqual(72, array[0], "should be ASCII code for 'H'")
        XCTAssertEqual(101, array[1], "should be ASCII code for 'e'")
        XCTAssertEqual(10, array[13], "should be ASCII code for '\\n'")
    }
    
    func test_sequenceOfBytesForFileAtPathForNonexistentFile() {
        var byteCount = 0
        var eofCount = 0
        for byteValue in sequenceOfBytesForFileAtPath("does_not_exist") {
            if byteValue == EOF {
                ++eofCount
            }
            else {
                ++byteCount
            }
        }
        XCTAssertEqual(0, byteCount, "should have read zero bytes")
        XCTAssertEqual(1, eofCount, "should have read EOF")
    }
}
