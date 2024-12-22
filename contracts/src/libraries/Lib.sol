// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {IErrandManager} from "../interfaces/IErrandManager.sol";

library Lib {
    struct NewClientParams {
        address client;
    }

    struct Client {
        address client;
        IErrandManager errandManager;
        address smartAccount;
    }

    // we are going to restrict this to a single stablecoin for now
    struct PaymentToken {
        address token;
        uint256 amount;
    }

    struct PostNewErrandParams {
        address client;
        uint256 expires;
        PaymentToken paymentToken;
    }
    struct Errand {
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
}
