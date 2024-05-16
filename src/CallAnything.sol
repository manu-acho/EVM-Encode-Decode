/*
Function Signatures
A function signature refers to the part of the function that defines its INTERFACE to the outside world without including the function body. It typically includes the function's name, the types of its parameters, and its return type. It is a string that defines the function's name and parameter types. The function signature is used to identify the function when calling it from another contract or from a web3 client.

Function Signature in Solidity:

In Solidity,the function signature is particularly important because it helps in the encoding and decoding of calls to these functions. Solidity function signatures include the function name and the list of parameter types.
Components of a Solidity Function Signature:

    Function Name: The name of the function as declared.
    Parameter Types: The data types of the input parameters, listed in order.

In order to call a function using only the data field of a call, we need to encode down to the binary level:
1. The function name 
2. The function parameters

Contracts assign functions an ID known as the function selector. 
- This is the first four bytes (32 bits) of the keccak256 hash of the function signature. This is used to identify the function that is being called. 
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract CallAnything {
    address public s_address;
    uint256 public s_amount;

    // create a function that takes an address and an amount
    function transfer(address _address, uint256 _amount) public {
        s_address = _address;
        s_amount = _amount;
    }

    // get the selector of the transfer function
    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    // get the data required to call the transfer function
    function getDataToCallTransferFunc(
        address _address,
        uint256 _amount
    ) public pure returns (bytes memory) {
        return abi.encodeWithSelector(getSelectorOne(), _address, _amount);
    }

    // call the transfer function directly
    // Version 1
    function callTransferFunctionDirectly(
        address _address,
        uint256 amount
    ) public returns (bool, bytes4) {
        // (bool success, bytes memory returnData) = address(this).call(getSelectorOne(), _address, amount);
        (bool success, bytes memory returnData) = address(this).call(
            getDataToCallTransferFunc(_address, amount)
        );
        return (success, bytes4(returnData));
    }
 
    // version 2
    function callTransferFunctionDirectlySig(
        address _address,
        uint256 amount
    ) public returns (bool, bytes4) {
        // (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(getSelectorOne(), _address, amount));
        (bool success, bytes memory returnData) = address(this).call(
            abi.encodeWithSignature(
                "transfer(address,uint256)",
                _address,
                amount
            )
        );
        return (success, bytes4(returnData));
    }

    // version 3
     function callTransferFunctionDirectlyv3(
        address _address,
        uint256 amount
    ) public returns (bool, bytes4) {
        // (bool success, bytes memory returnData) = address(this).call(getSelectorOne(), _address, amount);
        (bool success, bytes memory returnData) = address(this).call(abi.encodeWithSelector(getSelectorOne(), _address, amount));
        return (success, bytes4(returnData));
    }
}
