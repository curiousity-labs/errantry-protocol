// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals
    ) ERC20(name, symbol) {
        _mint(msg.sender, 10 ** 9 * 10 ** uint256(decimals)); // Mint 1 billion tokens to deployer
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }
}