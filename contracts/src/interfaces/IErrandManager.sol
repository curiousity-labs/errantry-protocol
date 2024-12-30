// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IErrandManager {
    struct PaymentToken {
        address tokenAddress;
        uint256 amount;
    }
    struct Errand {
        uint256 errandId;
        PaymentToken paymentToken; // the address of the runner, 0x0 if not yet assigned
        address runner;
        uint256 expires; // the block number when the errand expires
        uint8 status; // bitfield to store completed/paid/cancelled
    }

    function updateErrandRunner(uint256 errandId, address runner) external;

    function postNewErrand(
        uint256 errandId,
        address client,
        uint256 expires,
        address tokenAddress,
        uint256 amount
    ) external;
}
