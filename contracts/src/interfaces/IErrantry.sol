// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IErrandManager} from "./IErrandManager.sol";
import {ErrantryClientSmartAccount} from "../ErrantryClientSmartAccount.sol";

interface IErrantry {
    struct Client {
        address client;
        IErrandManager errandManager;
        ErrantryClientSmartAccount smartAccount;
    }

    struct PostNewErrandParams {
        address client;
        uint256 expires;
        address tokenAddress;
        uint256 amount;
    }

    error ClientAlreadyRegistered();

    event ClientRegistered(address client);

    function getErrandManagerAddress(address clientAddress) external view returns (address);

    function isClientRegistered(address clientAddress) external view returns (bool);

    function registerNewClient(address clientAddress) external;

    function postNewErrand(PostNewErrandParams calldata params) external;

    function updateErrandRunner(uint256 errandId, address clientAddress, address runner) external;

    function markErrandAsComplete(uint256 errandId, address clientAddress) external;

    function markErrandAsPaid(uint256 errandId, address clientAddress) external;

    function cancelErrand(uint256 errandId, address clientAddress) external;
}
