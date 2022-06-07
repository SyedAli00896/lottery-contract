// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "./Owner.sol";

error InsufficientAmount();

contract Lottery is Owner {
    address[] public players;

    function enter() public payable {
        if (msg.value < .01 ether) {
            revert InsufficientAmount();
        }
        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        // it's a psuedo random function, we must use decentralized oracles for random number generation
        return
            uint(
                keccak256(abi.encodePacked(block.difficulty, block.timestamp))
            );
    }

    function pickWinner() public onlyOwner returns (address) {
        uint index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
        return players[index];
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
