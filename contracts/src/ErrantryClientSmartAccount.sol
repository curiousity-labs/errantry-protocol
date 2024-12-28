// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../lib/account-abstraction/contracts/samples/SimpleAccount.sol";

contract ErrantryClientSmartAccount is SimpleAccount {
    address private TRUSTED_ORACLE;

    constructor(
        address _entryPoint,
        address TRUSTED_ORACLE
    ) SimpleAccount(_entryPoint) {}

    /* >>>>>>>> general external functions <<<<<<< */
    function validateUserOp(
        UserOperation calldata userOp,
        bytes32 userOpHash,
        uint256 missingAccountFunds
    ) external override returns (uint256 validationData) {
        // You could add custom checks here
        if (
            keccak256(abi.encodePacked(userOp.callData)) ==
            keccak256(abi.encodePacked("markErrandAsComplete()"))
        ) {
            // Ensure the caller is the trusted oracle
            require(msg.sender == trustedOracle, "Not authorized");
        }

        return super.validateUserOp(userOp, userOpHash, missingAccountFunds);
    }

    /* >>>>>>>> oracle functions <<<<<<< */
    function markErrandAsComplete() external {}

    /* >>>>>>>> internal functions <<<<<<< */
    function _checkErrandFundBalance() internal {}

    function _payErrands() internal {}
}
