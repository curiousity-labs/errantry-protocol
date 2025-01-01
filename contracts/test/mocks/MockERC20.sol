// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MockERC20
 * @dev A simple ERC20 token implementation for testing purposes.
 */
contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    /**
     * @dev Mints `amount` tokens to `account`.
     * @param account The account to mint tokens to.
     * @param amount The amount of tokens to mint.
     */
    function mint(address account, uint256 amount) external {
        _mint(account, amount);
    }

    /**
     * @dev Burns `amount` tokens from `account`.
     * @param account The account to burn tokens from.
     * @param amount The amount of tokens to burn.
     */
    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }
}
