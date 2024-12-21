// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol";

/**
 * Definitions:
 * - Errantry: the business of running errands
 * - Errand: a short task that needs to be done
 * - Errand Runner: a person who runs errands
 * - Errand Client: a person who requests errands to be run
 */

contract Errantry is ERC165 {

    /* >>>>>>>> errand runner functions <<<<<<< */
    function claimErrandPayment() external {}


    /* >>>>>>>> errand client functions <<<<<<< */
    function registerNewClient() external {}
    function postNewErrand() external {}
    function payErrandInvoice() external {}

    /* >>>>>>>> oracle functions <<<<<<< */
    function registerNewErrand() external {}
    function updateErrandStatus() external {}

    }

    /* >>>>>>>> internal functions <<<<<<< */






    // Override supportsInterface to specify supported interfaces
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
