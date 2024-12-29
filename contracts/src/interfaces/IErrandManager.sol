// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IErrandManager {
    struct PaymentToken {
        address tokenAddress;
        uint256 amount;
    }
    struct Errand {
        uint256 errandId;
        PaymentToken paymentToken;
        // the address of the runner, 0x0 if not yet assigned
        address runner;
        // the block number when the errand expires
        uint256 expires;
        /* >>>>>>>> errand status <<<<<<< */

        // @TODO for gas efficiency, we could use a bitfield to store the status
        // true if the errand has been completed
        bool completed;
        // true if the runner has been paid
        bool paid;
        bool cancelled;
    }

    function getErrand(uint256 errandId) external view returns (Errand memory);

    function updateErrandRunner(uint256 errandId, address runner) external;

    function postNewErrand(
        uint256 errandId,
        address client,
        uint256 expires,
        address tokenAddress,
        uint256 amount
    ) external;
}
