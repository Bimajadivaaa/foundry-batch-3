// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Vault is ERC20 {
    error AmountCannotBeZero();
    error SharesCannotBeMoreThanShares();

    address public assetToken;
    address public owner;

    constructor(address _assetToken) ERC20("Deposito Vault", "DEPO"){
        assetToken = _assetToken;
        owner = msg.sender;
    }

    function deposit(uint256 amount) public {
        // check balance
        if(amount == 0) revert AmountCannotBeZero();
        // amount tidak boleh 0


        // shares rumus = depo amount / total asset * total shares
        uint256 shares = 0;
        uint256 totalAssets = IERC20(assetToken).balanceOf(address(this));

        if(totalSupply() == 0){
            shares = amount;
        } else {
            // Kali harus selalu dilakukan karna solidity tidak bisa float
            shares = (amount * totalSupply()) / totalAssets;
        }

        _mint(msg.sender, shares);
        IERC20(assetToken).transferFrom(msg.sender, address(this), amount);

    }

    function withdraw(uint256 shares) external{
        // wd = shares /  total shares * total assets
        if(shares > balanceOf(msg.sender) || balanceOf(msg.sender) == 0) revert SharesCannotBeMoreThanShares();

        uint256 totalAssets = IERC20(assetToken).balanceOf(address(this));
        uint256 amount = (shares * totalAssets / totalSupply());

        _burn(msg.sender, shares);
        IERC20(assetToken).transfer(msg.sender, amount);
    }

    function distributeYield(uint256 amount) external {
        require(msg.sender == owner, "Only Owner can distribute yield");
        IERC20(assetToken).transferFrom(msg.sender, address(this), amount);
    }


}