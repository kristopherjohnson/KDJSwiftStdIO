# KDJSwiftStdIO

This is a simple library of functions for processing files in Swift, using C stdio as the underlying implementation.

## Examples

    // Process bytes from file as a lazy sequence
    let bytes = sequenceOfBytesForFileAtPath("foo.txt")
    for byteValue in bytes {
        if byteValue == EOF {
            // We had an error; handle it.
            // Note: EOF indicates "error"; it will not be received for end-of-file
        }
        else {
            // process the byte, which will have a value 0...255
        }
    }

    // Load byte values into an array.
    // If the last value in the array is EOF, it means something went wrong.
    let byteArray = Array<Int>(sequenceOfBytesForFileAtPath("foo.txt"))
    if byteArray[byteArray.count - 1] == EOF {
        // Handle error
    }
