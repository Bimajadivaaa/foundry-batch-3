// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenRupiah is ERC20 {
    constructor() ERC20("RUPIAH", "RP"){
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

}