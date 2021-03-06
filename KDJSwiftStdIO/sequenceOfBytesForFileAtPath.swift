//
//  sequenceOfBytesForFileAtPath.swift
//  KDJSwiftStdIO
//
//  Created by Kristopher Johnson on 7/19/14.
//  Copyright (c) 2014 Kristopher Johnson. All rights reserved.
//

import Foundation


// Return a sequence of Int32 values corresponding to bytes from a file.
//
// If an I/O error occurs, the value EOF (-1) will be the final value
// in the sequence.
//
// (Note that EOF will not appear in the sequence if the file is read
// from beginning to end without error.)
public func sequenceOfBytesForFileAtPath(path: String) -> SequenceOf<Int32> {
    return SequenceOf({FileByteReaderGenerator(path: path)})
}

public class FileByteReaderGenerator : Generator {
    private var isFinished: Bool
    private var file: UnsafePointer<FILE>
    
    public init(path: String) {
        let pathAsCString = path.bridgeToObjectiveC().UTF8String
        isFinished = false
        file = fopen(pathAsCString, "rb")
    }
    
    deinit {
        if file {
            fclose(file)
        }
    }
    
    public func next() -> Int32? {
        if isFinished {
            return nil
        }
        
        if !file {
            isFinished = true
            return EOF
        }
        
        let ch = fgetc(file)
        if ch != EOF {
            return ch
        }
        else if ferror(file) != 0 {
            isFinished = true
            return EOF
        }
        else {
            isFinished = true
            return nil
        }
    }
}
