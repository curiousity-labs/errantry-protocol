// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {SimpleAccount, IEntryPoint, PackedUserOperation, SIG_VALIDATION_SUCCESS} from "@account-abstraction/contracts/samples/SimpleAccount.sol";
import {IErrantryClientSmartAccount} from "./interfaces/IErrantryClientSmartAccount.sol";
import {IErrandManager} from "./interfaces/IErrandManager.sol";

contract ErrantryClientSmartAccount is IErrantryClientSmartAccount {
    constructor(
        IEntryPoint _entryPoint,
        address _trustedOracle,
        IErrandManager _errandManager
    )
        IErrantryClientSmartAccount(_entryPoint, _trustedOracle, _errandManager)
    {}

    /* >>>>>>>> general external functions <<<<<<< */
    function _validateSignature(
        PackedUserOperation calldata userOp,
        bytes32 userOpHash
    ) internal override returns (uint256 validationData) {
        bytes memory _callData = userOp.callData;
        // Extract the function selector from the first 4 bytes of callData
        bytes4 functionSelector;
        assembly {
            functionSelector := calldataload(add(_callData, 0x20)) // Skip the 32-byte length prefix of the bytes array
        }

        if (
            functionSelector == this.markErrandAsComplete.selector &&
            msg.sender == TRUSTED_ORACLE
        ) {
            // Return validation success without further signature checks
            return SIG_VALIDATION_SUCCESS;
        }

        // For other functions, proceed with the default signature validation
        return super._validateSignature(userOp, userOpHash);
    }

    /* >>>>>>>> oracle functions <<<<<<< */
    function markErrandAsComplete(uint256 errandId) external onlyOracle {}

    /* >>>>>>>> internal functions <<<<<<< */
    function _checkErrandFundBalance() internal {}

    function _payErrands() internal {}
}
