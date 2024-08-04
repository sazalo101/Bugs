// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;



contract ExampleTest is Test {
    Example public example;

    function setUp() public {
        example = new Example();
    }

    function testExample() public {}
}
