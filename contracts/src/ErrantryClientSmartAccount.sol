// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@account-abstraction/contracts/samples/SimpleAccount.sol";
import {IErrantryClientSmartAccount} from "./interfaces/IErrantryClientSmartAccount.sol";
import "./OnlyOracle.sol";

contract ErrantryClientSmartAccount is
    IErrantryClientSmartAccount,
    SimpleAccount,
    OnlyOracle
{
    constructor(
        IEntryPoint _entryPoint,
        address _trustedOracle
    ) SimpleAccount(_entryPoint) OnlyOracle(_trustedOracle) {}

    /* >>>>>>>> general external functions <<<<<<< */
    function _validateSignature(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash
    ) internal override returns (uint256 validationData) {
        // 1. Add custom checks
        //    e.g., require(msg.sender == TRUSTED_ORACLE, "Not authorized");

        // 2. Call the parent’s logic
        validationData = super._validateSignature(userOp, userOpHash);

        // 3. Return whatever the parent returns (or augment it)
        return validationData;
    }

    /* >>>>>>>> oracle functions <<<<<<< */
    function markErrandAsComplete() external onlyOracle {}

    /* >>>>>>>> internal functions <<<<<<< */
    function _checkErrandFundBalance() internal {}

    function _payErrands() internal {}
}
