// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Read notes  in encoding_notes.sol in addition to notes in this file.

contract Encoding {
    // Use abi.encodePacked to concatenate two strings
    // The strings are encoded into their byte representations and then typecasted to string and returned
    function combineStrings() public pure returns (string memory) {
        return string(abi.encodePacked("Hi Mom ", "Really Miss You")); // could also use string.concat()
    }

    /////////////////////////
    ///// abi.encode ////////
    /////////////////////////

    // Use abi.encode to encode a number (convert it to its binary representation)
    function encodeNumber() public pure returns (bytes memory) {
        bytes memory number = abi.encode(42); // encodes the number 42 into its byte representation
        return number; // encodes the number 42 into its byte representation
    }

    // encodes the string "Hello World" into its byte representation
    function encodeString() public pure returns (bytes memory) {
        bytes memory someString = abi.encode("Hello World");
        return someString;
    }

    /////////////////////////////
    ///// abi.encodePacked()/////
    ////////////////////////////

    // Use abi.encodePacked to encode compress data
    // To encode a string saving space without need for a perfect low level binary version

    function encodeStringPacked() public pure returns (bytes memory) {
        bytes memory someString = abi.encodePacked("Hello World");
        return someString;
    }

    // The function below returns the same output.
    // abi.encodePacked() is used to encode the string "Hello World" into its byte representation as shown below
    function encodeStringBytes() public pure returns (bytes memory) {
        bytes memory someString = bytes("Hello World");
        return someString;
    }

    ////////////////////////
    ///// abi.decode()//////
    ////////////////////////

    // Use abi.decode to decode a number from its binary representation
    function decodeString() public pure returns (string memory) {
        string memory decodedString = abi.decode(encodeString(), (string)); // abi.decode(endoded_data, type_decoded_to). See documentation
        return decodedString;
    }

    ////////////////////////
    ///// multiencode////////
    ///// multidecode////////
    ////////////////////////

    // Use abi.encode to encode multiple values
    function multiEncode2() public pure returns (bytes memory) {
        bytes memory encoded = abi.encode(42, " Hello World ", true);
        return encoded;
    }

    function multiEncode() public pure returns (bytes memory) {
        bytes memory encoded = abi.encode("Hello World ", "He is coming");
        return encoded;
    }

    // use abi.decode to decode multiple values
    function multiDecode() public pure returns (string memory, string memory) {
        (string memory a, string memory b) = abi.decode(
            multiEncode(),
            (string, string)
        );
        return (a, b);
    }

    // use abi.encodePacked() to encode multiple values
    function multiEncodePacked() public pure returns (bytes memory) {
        bytes memory multiEncoded = abi.encodePacked(
            "Hello World ",
            "He is coming"
        );
        return multiEncoded;
    }

    // This would not work
    function multiDecodePacked()
        public
        pure
        returns (string memory, string memory)
    {
        (string memory a, string memory b) = abi.decode(
            multiEncodePacked(),
            (string, string)
        );
        return (a, b);
    }

    function multiStringCastPacked() public pure returns (string memory) {
        string memory multiDecoded = string(multiEncodePacked());
        return multiDecoded;
    }

    /* 
    
    function multiStringCastPacked() public pure returns (string memory) {
        string memory multiDecoded = string(abi.encodePacked("Hello World ", "He is Coming"));
        return multiDecoded;
    }
    
    */
}

/* 
// opcodes are used to decode the contract initcode and contract bytecode in the data field. 
// bytecode is the compiled code that is deployed to the blockchain. The low level computer instructions that the EVM can understand.
In the context of Solidity and Ethereum, an ABI (Application Binary Interface) is a crucial component for interacting with smart contracts. It is essentially a standardized way to convert the human-readable Solidity contract methods and arguments into the low-level, machine-readable format that the Ethereum Virtual Machine (EVM) can understand. The ABI defines how to map the high-level contract functionalities (like function names, inputs, outputs) to the corresponding binary representations.


Key Functions of the ABI:

    Function Identifier: Every function in a Solidity contract is encoded into a 4-byte identifier, derived from the keccak-256 hash of its signature (the function name and the parenthesized list of parameter types). This identifier is used to uniquely identify and call functions.

    Data Encoding: The ABI specifies how the function arguments are encoded as inputs and how outputs are decoded back to their respective types. This includes encoding basic types (like uint256, string), arrays, and complex nested objects.

    Constructor Arguments: If a contract has a constructor with arguments, the ABI includes details about how these arguments should be passed when deploying the contract.

    Event Encoding: The ABI also defines the encoding for events, including how the event name and parameters are transformed into the log entries that the Ethereum blockchain stores.

Components of an ABI:

An ABI is usually represented in JSON format and typically includes the following information for each function and event:

    Type: Whether the item is a function, constructor, event, or an error.
    Name: The name of the function or event.
    Inputs: List of input parameters including name and type of each parameter.
    Outputs: List of output parameters, applicable to functions that return values.
    StateMutability: This describes the function's effect on the state of the contract (e.g., pure, view, nonpayable, payable).
        pure functions promise not to read from or modify the contract's state.
        view functions declare that they do not modify the state, but they can read from it.
        nonpayable functions do not accept Ether.
        payable functions can accept Ether along with the call.
    Anonymous: Used for events. If true, the event signature is not included in the log’s topics.

Practical Use:

When you interact with a contract on Ethereum from a frontend application or another contract, you use the ABI to:

    Compile the contract: Solidity compilers like solc or Remix produce the ABI as part of the compilation output, which can be used by frontend applications.
    Contract Deployment: Tools like Truffle, Hardhat, or web3.js require the ABI to deploy contracts to the Ethereum network.
    Interact with Deployed Contracts: To call functions or listen to events of a deployed contract, client-side libraries like web3.js or ethers.js need the ABI to encode calls and decode responses.
    */
