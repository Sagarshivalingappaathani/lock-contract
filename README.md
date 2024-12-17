# Forge Standard Library

Forge Standard Library is a collection of helpful contracts for use with [`forge` and `foundry`](https://github.com/gakonst/foundry).  It leverages `forge`'s cheatcodes to make writing tests easier and faster, while improving the UX of cheatcodes. For more in-depth usage examples, check out the [tests](https://github.com/brockelmore/forge-std/blob/master/src/test).


## Installation

```bash
forge install foundry-rs/forge-std
```

## Contracts

### `stdError`

This is a helper contract for errors and reverts. In `forge`, this contract is particularly helpful for the `expectRevert` cheatcode, as it provides all compiler builtin errors.

See the contract itself for all error codes.

#### Example Usage

```solidity
import "forge-std/Test.sol";

contract TestContract is Test {
    ErrorsTest test;

    function setUp() public {
        test = new ErrorsTest();
    }

    function testExpectArithmetic() public {
        vm.expectRevert(stdError.arithmeticError);
        test.arithmeticError(10);
    }
}

contract ErrorsTest {
    function arithmeticError(uint256 a) public {
        uint256 a = a - 100;
    }
}
```

### `stdStorage`

This is a wrapper around the `record` and `accesses` cheatcodes. It can find and write the storage slot(s) associated with a particular variable without knowing the storage layout.  The major caveat is that while a slot can be found for packed storage variables, writing to them safely isn't guaranteed.  If a user tries to write to a packed slot, execution throws an error unless it's uninitialized (`bytes32(0)`).

This works by recording all `SLOAD`s and `SSTORE`s during a function call. If there's a single slot read or written, it immediately returns the slot. Otherwise, it iterates and checks each one (assuming a `depth` parameter is passed).  For structs, the `depth` parameter specifies the field depth.

#### Example Usage

```solidity
import "forge-std/Test.sol";

contract TestContract is Test {
    using stdStorage for StdStorage;

    Storage test;

    function setUp() public {
        test = new Storage();
    }

    // ... (Example usage demonstrating `find`, `checked_write`, etc.  Refer to the original README for the full example) ...
}

// ... (Storage contract definition. Refer to the original README for the full example) ...
```

### `stdCheats`

This is a wrapper over miscellaneous cheatcodes. Currently, it includes functions related to `prank`.  The `hoax` function should only be used for addresses with expected balances, as it overwrites existing balances. Use `prank` for addresses with existing ETH, `deal` to change balances explicitly, or `hoax` to do both.

#### Example Usage

```solidity
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

// ... (Example usage demonstrating `hoax`, `startHoax`, etc. Refer to the original README for the full example) ...
```

### `console.log`

Usage follows the same format as [Hardhat](https://hardhat.org/hardhat-network/reference/#console-log):

```solidity
// import it indirectly via Test.sol
import "forge-std/Test.sol";
// or directly import it
import "forge-std/console.sol";
...
console.log(someValue);
```

## Contact Information

(Please add contact information here if needed)
