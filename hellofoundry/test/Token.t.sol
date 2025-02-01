// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;
    address public alice = makeAddr("alice");

    function setUp() public {
        token = new Token();
    }

    function test_mint() public {
        token.mint(address(this), 1000);
        assertEq(
            token.balanceOf(address(this)),
            1000,
            "balance should be 1000"
        );
    }

    function test_mint_max_supply() public {
        assertEq(token.MAX_TOTAL_SUPPLY(), 10_000);
        //Console log total supply
        // console.log("Total supply: ", token.totalSupply());
        vm.expectRevert("Max supply exceeded");
        token.mint(address(this), 8000);
        console.log("Total supply: ", token.totalSupply());
    }

     function test_mint_up_to_max_supply() public {
        token.mint(address(this), 10_000);
        assertEq(
            token.totalSupply(),
            10_000,
            "total supply should be 10,000"
        );
    }

    function test_mint_beyond_max_supply() public {
        token.mint(address(this), 10_000);
        vm.expectRevert("Max supply exceeded");
        token.mint(address(this), 1);
    }

    function test_mint_exact_max_supply() public {
        token.mint(address(this), 10_000);
        assertEq(
            token.totalSupply(),
            100_000,
            "total supply should be exactly 10,000"
        );
    }
}