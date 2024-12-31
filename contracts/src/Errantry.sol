// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IErrantry} from "./interfaces/IErrantry.sol";
import {IErrandManager} from "./interfaces/IErrandManager.sol";
import {ErrandManager} from "./ErrandManager.sol";
import {ErrantryClientSmartAccount} from "./ErrantryClientSmartAccount.sol";
import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {PackedUserOperation} from "@account-abstraction/contracts/interfaces/PackedUserOperation.sol";
import "./OnlyOracle.sol";

contract Errantry is IErrantry, OnlyOracle {
    IEntryPoint private SA_ENTRY_POINT;

    mapping(address => Client) private clients;

    constructor(IEntryPoint _entry_point, address _trusted_oracle) OnlyOracle(_trusted_oracle) {
        SA_ENTRY_POINT = _entry_point;
    }

    function getErrandManagerAddress(address clientAddress) public view override returns (address) {
        return address(clients[clientAddress].errandManager);
    }

    function isClientRegistered(address clientAddress) public view override returns (bool) {
        return clients[clientAddress].client != address(0);
    }

    function registerNewClient(address clientAddress) external override {
        if (clients[clientAddress].client != address(0)) {
            revert ClientAlreadyRegistered();
        }
        ErrantryClientSmartAccount clientSmartAccount = new ErrantryClientSmartAccount(SA_ENTRY_POINT, TRUSTED_ORACLE);
        clients[msg.sender] = Client({
            client: msg.sender,
            errandManager: new ErrandManager(address(clientSmartAccount)),
            smartAccount: clientSmartAccount
        });

        emit ClientRegistered(msg.sender, address(0));
    }

    function postNewErrand(PostNewErrandParams calldata params) public override onlyOracle {
        clients[params.client].errandManager.postNewErrand(
            params.errandId, params.client, params.expires, params.tokenAddress, params.amount
        );
    }

    function updateErrandRunner(uint256 errandId, address clientAddress, address runner) external override {
        clients[clientAddress].errandManager.updateErrandRunner(errandId, runner);
    }
}
