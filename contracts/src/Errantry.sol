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

    event ClientRegistered(address indexed client, address smartAccount);

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

        emit ClientRegistered(msg.sender, address(0));
    }

    /* >>>>>>>> oracle functions <<<<<<< */

    /* >>>>>>>> internal functions <<<<<<< */
}
