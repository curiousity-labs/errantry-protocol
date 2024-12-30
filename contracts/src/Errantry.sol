// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IErrantry} from "./interfaces/IErrantry.sol";
import {IErrandManager} from "./interfaces/IErrandManager.sol";
import {ErrandManager} from "./ErrandManager.sol";
import {ErrantryClientSmartAccount} from "./ErrantryClientSmartAccount.sol";
import {IErrantryClientSmartAccount} from "./interfaces/IErrantryClientSmartAccount.sol";
import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {PackedUserOperation} from "@account-abstraction/contracts/interfaces/PackedUserOperation.sol";
import "./OnlyOracle.sol";

/**
 * Definitions:
 * - Errantry: the business of running errands
 * - Errand: a short task that needs to be done
 * - Errand Runner: a person who runs errands
 * - Errand Client: a person who requests errands to be run
 */
contract Errantry is IErrantry, OnlyOracle {
    IEntryPoint private SA_ENTRY_POINT;

    error ClientAlreadyRegistered();

    event ClientRegistered(address indexed client, address smartAccount);

    struct Client {
        address client;
        IErrandManager errandManager;
        IErrantryClientSmartAccount smartAccount;
    }

    struct PostNewErrandParams {
        uint256 errandId;
        address client;
        uint256 expires;
        address tokenAddress;
        uint256 amount;
    }

    // only the oracle can post new errands

    mapping(address => Client) private clients;

    constructor(IEntryPoint _entry_point, address _trusted_oracle) OnlyOracle(_trusted_oracle) {
        SA_ENTRY_POINT = _entry_point;
    }

    /* >>>>>>>> open access external functions <<<<<<< */
    function getErrandManagerAddress(address clientAddress) public view returns (address) {
        return address(clients[clientAddress].errandManager);
    }

    function isClientRegistered(address clientAddress) public view returns (bool) {
        return clients[clientAddress].client != address(0);
    }

    /* >>>>>>>> errand runner functions <<<<<<< */
    function claimErrandPayment() external {}

    /* >>>>>>>> errand client functions <<<<<<< */
    function registerNewClient(address clientAddress) external {
        if (clients[clientAddress].client != address(0)) {
            revert ClientAlreadyRegistered();
        }
        clients[msg.sender] = Client({
            client: msg.sender,
            errandManager: new ErrandManager(),
            smartAccount: new ErrantryClientSmartAccount(SA_ENTRY_POINT, TRUSTED_ORACLE)
        });

        emit ClientRegistered(msg.sender, address(0));
    }

    /* >>>>>>>> oracle functions <<<<<<< */
    function postNewErrand(PostNewErrandParams calldata params) public onlyOracle {
        clients[params.client].errandManager.postNewErrand(
            params.errandId, params.client, params.expires, params.tokenAddress, params.amount
        );
    }

    function updateErrandRunner(uint256 errandId, address clientAddress, address runner) external {
        clients[clientAddress].errandManager.updateErrandRunner(errandId, runner);
    }

    /* >>>>>>>> internal functions <<<<<<< */
}
