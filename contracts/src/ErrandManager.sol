// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {IErrandManager} from "./interfaces/IErrandManager.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * Definitions:
 * - Errantry: the business of running errands
 * - Errand: a short task that needs to be done
 * - Errand Runner: a person who runs errands
 * - Errand Client: a person who requests errands to be run
 */

/**
 * @title ErrandManager
 * @author @Da-Colon
 * @notice ErandManager is complimentary to the Errantry contract.
 * @notice Functions must be called by the Errantry contract via the oracle.
 */
contract ErrandManager is IErrandManager, Ownable {
    // @TODO decide if constant is the way to do go.
    // uint8 constant STATUS_COMPLETED = 1 << 0; // 1 (binary 00000001)
    // uint8 constant STATUS_PAID = 1 << 1; // 2 (binary 00000010)
    // uint8 constant STATUS_CANCELLED = 1 << 2; // 4 (binary 00000100)

    event ErrandPosted(
        uint256 indexed errandId,
        address indexed client,
        address indexed runner,
        address paymentToken,
        uint256 paymentAmount,
        uint256 expires
    );
    mapping(uint256 => Errand) public errands;

    constructor() Ownable(msg.sender) {}

    /* >>>>>>>> errand runner functions <<<<<<< */

    /* >>>>>>>> errand client functions <<<<<<< */

    /* >>>>>>>> oracle functions <<<<<<< */
    function postNewErrand(
        uint256 errandId,
        address client,
        uint256 expires,
        address tokenAddress,
        uint256 amount
    ) external onlyOwner {
        errands[errandId] = Errand({
            errandId: errandId,
            paymentToken: PaymentToken({
                tokenAddress: tokenAddress,
                amount: amount
            }),
            runner: address(0),
            expires: expires,
            status: 0 // initialized at 0 (not completed, not paid, not cancelled)
        });

        emit ErrandPosted(
            errandId,
            client,
            address(0),
            tokenAddress,
            amount,
            expires
        );
    }

    function updateErrandRunner(
        uint256 errandId,
        address runner
    ) external onlyOwner {
        errands[errandId].runner = runner;
    }

    function markErrandAsComplete(
        IErrandManager _errandManager,
        uint256 errandId
    ) external onlyOwner {}

    /* >>>>>>>> internal functions <<<<<<< */
    function _setStatus(uint256 errandId, uint8 flag) internal {
        errands[errandId].status |= flag;
    }

    function _clearStatus(uint256 errandId, uint8 flag) internal {
        errands[errandId].status &= ~flag;
    }

    function _hasStatus(
        uint256 errandId,
        uint8 flag
    ) internal view returns (bool) {
        return (errands[errandId].status & flag) != 0;
    }
}
