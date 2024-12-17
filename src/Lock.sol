// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Lock {
    address public tokenAddress; 
    mapping(address => uint256) public pendingAmt;


    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Invalid token address");
        tokenAddress = _tokenAddress;
    }

    function deposit(uint256 amt) public {
        IERC20 token = IERC20(tokenAddress);
        require(token.allowance(msg.sender, address(this)) >= amt, "Allowance too low");
        require(token.transferFrom(msg.sender, address(this), amt), "Transfer failed");
        pendingAmt[msg.sender] += amt;
    }

    function withdraw(uint256 amt) public {
        require(pendingAmt[msg.sender] >= amt, "Insufficient balance");
        pendingAmt[msg.sender] -= amt;
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(msg.sender, amt), "Transfer failed");

    }
}
