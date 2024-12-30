// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {
    SimpleAccount,
    IEntryPoint,
    PackedUserOperation,
    SIG_VALIDATION_SUCCESS
} from "@account-abstraction/contracts/samples/SimpleAccount.sol";
import {IErrantryClientSmartAccount} from "./interfaces/IErrantryClientSmartAccount.sol";
import {IErrandManager} from "./interfaces/IErrandManager.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ErrantryClientSmartAccount is IErrantryClientSmartAccount {
    constructor(IEntryPoint _entryPoint, address _trustedOracle)
        IErrantryClientSmartAccount(_entryPoint, _trustedOracle)
    {}

    /* >>>>>>>> general external functions <<<<<<< */
    function payErrands() external override {
        _payErrands();
    }

    /* >>>>>>>> overridden functions <<<<<<< */
    function _validateSignature(PackedUserOperation calldata userOp, bytes32 userOpHash)
        internal
        override
        returns (uint256 validationData)
    {
        bytes memory _callData = userOp.callData;
        // Extract the function selector from the first 4 bytes of callData
        bytes4 functionSelector;
        assembly {
            functionSelector := calldataload(add(_callData, 0x20)) // Skip the 32-byte length prefix of the bytes array
        }

        // if (
        //     functionSelector == this.markErrandAsComplete.selector &&
        //     msg.sender == TRUSTED_ORACLE
        // ) {
        //     // Return validation success without further signature checks
        //     return SIG_VALIDATION_SUCCESS;
        // }

        // For other functions, proceed with the default signature validation
        return super._validateSignature(userOp, userOpHash);
    }

    /* >>>>>>>> internal functions <<<<<<< */
    function _checkErrandFundBalance(address token, uint256 requiredAmount) internal view {
        uint256 balance = IERC20(token).balanceOf(address(this));
        require(balance >= requiredAmount, "Insufficient token balance for errands");
    }

    function _payErrands() internal {}
}
