// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {SimpleAccount, IEntryPoint} from "@account-abstraction/contracts/samples/SimpleAccount.sol";
import {OnlyOracle} from "../OnlyOracle.sol";
import {IErrandManager} from "./IErrandManager.sol";

abstract contract IErrantryClientSmartAccount is SimpleAccount, OnlyOracle {
    IErrandManager private ERRAND_MANAGER;

    constructor(
        IEntryPoint _entryPoint,
        address _trustedOracle,
        IErrandManager _errandManager
    ) SimpleAccount(_entryPoint) OnlyOracle(_trustedOracle) {
        ERRAND_MANAGER = _errandManager;
    }
}
