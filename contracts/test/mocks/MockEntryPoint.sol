// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@account-abstraction/contracts/interfaces/IEntryPoint.sol";

/**
 * @title MockEntryPoint
 * @notice A complete implementation of IEntryPoint for mocking and testing purposes.
 * @dev Implements all required methods from IEntryPoint, IStakeManager, and INonceManager.
 */
contract MockEntryPoint is IEntryPoint {
    function handleOps(PackedUserOperation[] calldata, /*ops*/ address payable /*beneficiary*/ ) external override {
        // Add custom mock logic if required.
    }

    function handleAggregatedOps(UserOpsPerAggregator[] calldata, /*opsPerAggregator*/ address payable /*beneficiary*/ )
        external
        override
    {
        // Add custom mock logic if required.
    }

    function getUserOpHash(PackedUserOperation calldata /*userOp*/ ) external pure override returns (bytes32) {
        return keccak256(abi.encodePacked("mock-user-op-hash"));
    }

    function getSenderAddress(bytes memory /*initCode*/ ) external pure override {
        revert SenderAddressResult(address(0));
    }

    function delegateAndRevert(address, /*target*/ bytes calldata /*data*/ ) external pure override {
        revert DelegateAndRevert(false, "");
    }

    function getDepositInfo(address /*account*/ ) external pure override returns (DepositInfo memory) {
        return DepositInfo(0, false, 0, 0, 0);
    }

    function balanceOf(address /*account*/ ) external pure override returns (uint256) {
        return 0;
    }

    function depositTo(address /*account*/ ) external payable override {
        // Do nothing
    }

    function addStake(uint32 /*_unstakeDelaySec*/ ) external payable override {
        // Do nothing
    }

    function unlockStake() external override {
        // Do nothing
    }

    /**
     * Mock implementation of withdrawStake.
     */
    function withdrawStake(address payable /*withdrawAddress*/ ) external override {
        // Do nothing
    }

    function withdrawTo(address payable, /*withdrawAddress*/ uint256 /*withdrawAmount*/ ) external override {
        // Do nothing
    }

    function getNonce(address, /*sender*/ uint192 /*key*/ ) external pure override returns (uint256) {
        return 0;
    }

    function incrementNonce(uint192 /*key*/ ) external override {
        // Do nothing
    }
}
