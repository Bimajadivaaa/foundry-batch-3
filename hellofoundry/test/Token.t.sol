// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;
    address public alice = makeAddr('alice');

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function test_setPrice() public {
        counter.setPrice(100);
        assertEq(counter.price(), 100, 'price should be 100');
        console.log("price", counter.price());

        vm.prank(alice);
        vm.expectRevert("Only Owner can set price");
        counter.setPrice(200);
        
    }
}
