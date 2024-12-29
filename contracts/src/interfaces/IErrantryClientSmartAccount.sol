// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {SimpleAccount, IEntryPoint} from "@account-abstraction/contracts/samples/SimpleAccount.sol";
import {OnlyOracle} from "../OnlyOracle.sol";
import {IErrandManager} from "./IErrandManager.sol";

abstract contract IErrantryClientSmartAccount is SimpleAccount, OnlyOracle {
    constructor(
        IEntryPoint _entryPoint,
        address _trustedOracle
    ) SimpleAccount(_entryPoint) OnlyOracle(_trustedOracle) {}
}
