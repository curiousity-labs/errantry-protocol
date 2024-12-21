// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library Lib {
    struct NewClientParams {
        address client;
        // address eligiblityModule;
        address eligibility;
    }
    struct Errand {
        address payer; // the smart account that will pay the runner
        address runner; // the address of the runner
        uint256 expires; // the block number when the errand expires
        // @todo for gas efficiency, we could use a bitfield to store the status
        bool completed; // true if the errand has been completed
        bool paid; // true if the runner has been paid
    }
}
