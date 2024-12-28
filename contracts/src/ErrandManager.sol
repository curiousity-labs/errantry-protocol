// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {Lib} from "./libraries/Lib.sol";
import {IErrandManager} from "./interfaces/IErrandManager.sol";

/**
 * Definitions:
 * - Errantry: the business of running errands
 * - Errand: a short task that needs to be done
 * - Errand Runner: a person who runs errands
 * - Errand Client: a person who requests errands to be run
 */

contract ErrandManager is IErrandManager {
    event ErrandPosted(
        uint256 indexed errandId,
        address indexed client,
        address indexed runner,
        address paymentToken,
        uint256 paymentAmount,
        uint256 expires
    );
    mapping(uint256 => Lib.Errand) public errands;

    constructor() {}

    /* >>>>>>>> errand runner functions <<<<<<< */

    /* >>>>>>>> errand client functions <<<<<<< */

    /* >>>>>>>> oracle functions <<<<<<< */
    function postNewErrand(Lib.PostNewErrandParams calldata params) external {
        errands[params.errandId] = Lib.Errand({
            errandId: params.errandId,
            paymentToken: params.paymentToken,
            runner: address(0),
            expires: params.expires,
            completed: false,
            paid: false,
            cancelled: false
        });

        emit ErrandPosted(
            params.errandId,
            params.client,
            address(0),
            params.paymentToken.tokenAddress,
            params.paymentToken.amount,
            params.expires
        );
    }

    function getErrand(
        uint256 errandId
    ) external view returns (Lib.Errand memory) {
        return errands[errandId];
    }

    function updateErrandCancelled(uint256 errandId) external {
        Lib.Errand storage errand = errands[errandId];
        errand.cancelled = true;
    }

    function updateErrandCompleted(uint256 errandId) external {
        Lib.Errand storage errand = errands[errandId];
        errand.completed = true;
    }

    function updateErrandRunner(
        uint256 errandId,
        address runner
    ) external override {
        Lib.Errand storage errand = errands[errandId];
        errand.runner = runner;
    }

    /* >>>>>>>> internal functions <<<<<<< */
}
