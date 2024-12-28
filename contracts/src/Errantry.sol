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

    mapping(address => Lib.Client) private clients;

    constructor() {}

    /* >>>>>>>> open access external functions <<<<<<< */
    function getErrandManagerAddress(
        address clientAddress
    ) public view returns (address) {
        return address(clients[clientAddress].errandManager);
    }

    function isClientRegistered(
        address clientAddress
    ) public view returns (bool) {
        return clients[clientAddress].client != address(0);
    }

    /* >>>>>>>> errand runner functions <<<<<<< */
    function claimErrandPayment() external {}

    /* >>>>>>>> errand client functions <<<<<<< */
    function registerNewClient(address clientAddress) external {
        if (clients[clientAddress].client != address(0)) {
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
    function postNewErrand(Lib.PostNewErrandParams calldata params) public {
        clients[params.client].errandManager.postNewErrand(params);
    }

    function updateErrandRunner(
        uint256 errandId,
        address clientAddress,
        address runner
    ) external {
        clients[clientAddress].errandManager.updateErrandRunner(
            errandId,
            runner
        );
    }

    /* >>>>>>>> internal functions <<<<<<< */
}
