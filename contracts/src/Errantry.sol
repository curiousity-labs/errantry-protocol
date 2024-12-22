// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {IErrantry} from "./interfaces/IErrantry.sol";
import {ErrandManager} from "./ErrandManager.sol";
import {Lib} from "./libraries/Lib.sol";

/**
 * Definitions:
 * - Errantry: the business of running errands
 * - Errand: a short task that needs to be done
 * - Errand Runner: a person who runs errands
 * - Errand Client: a person who requests errands to be run
 */

contract Errantry is IErrantry {
    error ClientAlreadyRegistered();

    mapping(address => Lib.Client) public clients;

    constructor() {}

    /* >>>>>>>> errand runner functions <<<<<<< */
    function claimErrandPayment() external {}

    /* >>>>>>>> errand client functions <<<<<<< */
    function registerNewClient() external {
        if (clients[msg.sender].client != address(0)) {
            revert ClientAlreadyRegistered();
        }
        clients[msg.sender] = Lib.Client({
            client: msg.sender,
            errandManager: new ErrandManager(),
            smartAccount: address(0)
        });
    }

    // function postNewErrand(Lib.PostNewErrandParams calldata params) external {
    //     Lib.Errand({
    //         payer: params.client,
    //         runner: address(0),
    //         expires: params.expires,
    //         completed: false,
    //         paid: false
    //     });
    // }

    function payErrandInvoice() external {}

    /* >>>>>>>> oracle functions <<<<<<< */
    function registerNewErrand() external {}

    function updateErrandStatus() external {}

    /* >>>>>>>> internal functions <<<<<<< */
}
