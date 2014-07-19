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
func sequenceOfBytesForFileAtPath(path: String) -> SequenceOf<Int32> {
    return SequenceOf({FileByteReaderGenerator(path: path)})
}

class FileByteReaderGenerator : Generator {
    var _finished: Bool
    var _file: UnsafePointer<FILE>
    
    init(path: String) {
        let pathAsCString = path.bridgeToObjectiveC().UTF8String
        _finished = false
        _file = fopen(pathAsCString, "rb")
    }
    
    deinit {
        if _file {
            fclose(_file)
        }
    }
    
    func next() -> Int32? {
        if _finished {
            return nil
        }
        
        if !_file {
            _finished = true
            return EOF
        }
        
        let ch = fgetc(_file)
        if ch != EOF {
            return ch
        }
        else if ferror(_file) != 0 {
            _finished = true
            return EOF
        }
        else {
            _finished = true
            return nil
        }
    }
}
