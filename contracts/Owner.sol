// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
error Unauthorized();

contract Owner {
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        _;
    }
}
