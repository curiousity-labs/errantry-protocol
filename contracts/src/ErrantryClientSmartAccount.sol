// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {
    SimpleAccount,
    IEntryPoint,
    PackedUserOperation,
    SIG_VALIDATION_SUCCESS
} from "@account-abstraction/contracts/samples/SimpleAccount.sol";
import {IErrandManager} from "./interfaces/IErrandManager.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {OnlyOracle} from "./OnlyOracle.sol";

contract ErrantryClientSmartAccount is SimpleAccount, OnlyOracle {
    using SafeERC20 for IERC20;

    error ErrandManagerMismatch();

    constructor(IEntryPoint _entryPoint, address _trustedOracle)
        SimpleAccount(_entryPoint)
        OnlyOracle(_trustedOracle)
    {}
    /* >>>>>>>> general external functions <<<<<<< */

    function payErrands(IErrandManager errandManager) external {
        require(errandManager.getClientSmartAccountAddress() == address(this), ErrandManagerMismatch());
        IErrandManager.Errand[] memory errands = errandManager.getUnPaidErrands();

        for (uint256 i = 0; i < errands.length; i++) {
            IErrandManager.Errand memory errand = errands[i];
            address token = errand.paymentToken.tokenAddress;
            uint256 amount = errand.paymentToken.amount;
            if (!_checkErrandFundBalance(token, amount)) {
                continue;
            }
            // @dev IDE warning: "Possible reentrancy in `ErrantryClientSmartAccount.payErrands(contract IErrandManager)`"
            // @dev We are confident that the `markErrandAsPaid` function is safe to call
            // ignore reentrancy warning
            // solhint-disable-next-line reentrancy
            errandManager.markErrandAsPaid(i);
            IERC20(token).safeTransfer(errand.runner, amount);
        }
    }

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

        if (functionSelector == this.payErrands.selector && msg.sender == TRUSTED_ORACLE) {
            // Return validation success without further signature checks
            return SIG_VALIDATION_SUCCESS;
        }

        // For other functions, proceed with the default signature validation
        return super._validateSignature(userOp, userOpHash);
    }

    /* >>>>>>>> internal functions <<<<<<< */
    function _checkErrandFundBalance(address token, uint256 requiredAmount) internal view returns (bool) {
        return IERC20(token).balanceOf(address(this)) >= requiredAmount;
    }
}
