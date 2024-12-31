// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IErrandManager} from "./interfaces/IErrandManager.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ErrandManager
 * @author @Da-Colon
 * @notice ErandManager is complimentary to the Errantry contract.
 * @notice Functions must be called by the Errantry contract via the oracle.
 */
contract ErrandManager is IErrandManager, Ownable {
    address public CLIENT_SMART_ACCOUNT_ADDRESS;
    uint8 constant STATUS_COMPLETED = 1 << 0; // 1 (binary 00000001)
    uint8 constant STATUS_PAID = 1 << 1; // 2 (binary 00000010)
    uint8 constant STATUS_CANCELLED = 1 << 2; // 4 (binary 00000100)

    uint256 public errandCount;
    mapping(uint256 => Errand) public errands;

    constructor(address clientSmartAccount) Ownable(msg.sender) {
        CLIENT_SMART_ACCOUNT_ADDRESS = clientSmartAccount;
    }

    function postNewErrand(uint256 errandId, address client, uint256 expires, address tokenAddress, uint256 amount)
        external
        onlyOwner
    {
        errands[errandCount] = Errand({
            paymentToken: PaymentToken({tokenAddress: tokenAddress, amount: amount}),
            runner: address(0),
            expires: expires,
            status: 0 // initialized at 0 (not completed, not paid, not cancelled)
        });
        errandCount++;

        emit ErrandPosted(errandId, client, address(0), tokenAddress, amount, expires);
    }

    function updateErrandRunner(uint256 errandId, address runner) external onlyOwner {
        errands[errandId].runner = runner;
    }

    function markErrandAsComplete(uint256 errandId) external onlyOwner {
        require(_hasStatus(errandId, STATUS_COMPLETED), ErrandAlreadyCompleted());
        _setStatus(errandId, STATUS_COMPLETED);
        emit ErrandCompleted(errandId);
    }

    function markErrandAsPaid(uint256 errandId) external onlyOwner {
        require(_hasStatus(errandId, STATUS_COMPLETED), ErrandNotCompleted());
        require(_hasStatus(errandId, STATUS_PAID), ErrandAlreadyPaid());
        _setStatus(errandId, STATUS_PAID);
        emit ErrandPaid(errandId);
    }

    function cancelErrand(uint256 errandId) external onlyOwner {
        require(!_hasStatus(errandId, STATUS_COMPLETED), ErrandAlreadyCompleted());
        _setStatus(errandId, STATUS_CANCELLED);
        emit ErrandCancelled(errandId);
    }

    function getUnPaidErrands() external view returns (Errand[] memory) {
        Errand[] memory unPaidErrands = new Errand[](errandCount);
        uint256 j = 0;
        for (uint256 i = 0; i < errandCount; i++) {
            if (!_hasStatus(i, STATUS_PAID) && _hasStatus(i, STATUS_COMPLETED)) {
                unPaidErrands[j] = errands[i];
                j++;
            }
        }

        return unPaidErrands;
    }

    function getClientSmartAccountAddress() external view returns (address) {
        return CLIENT_SMART_ACCOUNT_ADDRESS;
    }

    function _setStatus(uint256 errandId, uint8 flag) private {
        errands[errandId].status |= flag;
    }

    function _hasStatus(uint256 errandId, uint8 flag) private view returns (bool) {
        return (errands[errandId].status & flag) != 0;
    }
}
