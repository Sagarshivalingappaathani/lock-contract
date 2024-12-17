// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/USDT.sol";
import "src/Lock.sol";

contract TestContract is Test {
    USDT usdt;
    Lock lock;

    function setUp() public {
        usdt = new USDT();
        lock = new Lock(address(usdt));
    }

    function test() public {
        //minting 
        usdt.mint(0x9EF3E99C48aE8474F7fBDECe3F701582e07c151f, 200);
        assert(usdt.balanceOf(0x9EF3E99C48aE8474F7fBDECe3F701582e07c151f)==200);

        //change vm
        vm.startPrank(0x9EF3E99C48aE8474F7fBDECe3F701582e07c151f);

        //allowance logic
        usdt.approve(address(lock), 200);

        //check lock balence
        lock.deposit(100);

        assert(usdt.balanceOf(address(lock))==100);
        assert(usdt.balanceOf(0x9EF3E99C48aE8474F7fBDECe3F701582e07c151f) == 100);

        lock.withdraw(50);
        assert(usdt.balanceOf(address(lock)) == 50);
        assert(usdt.balanceOf(0x9EF3E99C48aE8474F7fBDECe3F701582e07c151f) == 150);

    }
}
