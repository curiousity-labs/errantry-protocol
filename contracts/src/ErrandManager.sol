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

contract ErrandManager is IErrandManager, Ownable {
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
    ) external {
        errands[errandId] = Errand({
            errandId: errandId,
            paymentToken: PaymentToken({
                tokenAddress: tokenAddress,
                amount: amount
            }),
            runner: address(0),
            expires: expires,
            completed: false,
            paid: false,
            cancelled: false
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

    function getErrand(uint256 errandId) external view returns (Errand memory) {
        return errands[errandId];
    }

    function updateErrandCancelled(uint256 errandId) external {
        errands[errandId].cancelled = true;
    }

    function updateErrandCompleted(uint256 errandId) external {
        errands[errandId].completed = true;
    }

    function updateErrandRunner(uint256 errandId, address runner) external {
        errands[errandId].runner = runner;
    }

    /* >>>>>>>> internal functions <<<<<<< */
}
