# KDJSwiftStdIO

This is a simply library for functions for processing files using Swift, using C stdio as the underlying implementation.

## Examples

    for byteValue in sequenceOfBytesForFileAtPath("foo.txt") {
        if byteValue == EOF {
            // we had an error; handle it
        }
        else {
            // process the byte, which will have a value 0...255
        }
    }
