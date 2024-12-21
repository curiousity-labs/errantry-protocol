// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


import "./Lib.sol";
/**
 * Definitions:
 * - Errantry: the business of running errands
 * - Errand: a short task that needs to be done
 * - Errand Runner: a person who runs errands
 * - Errand Client: a person who requests errands to be run
 */

contract Errantry {
    /* >>>>>>>> errand runner functions <<<<<<< */
    function claimErrandPayment() external {}

    /* >>>>>>>> errand client functions <<<<<<< */
    function registerNewClient() external {}
    function postNewErrand() external {}
    function payErrandInvoice() external {}

    /* >>>>>>>> oracle functions <<<<<<< */
    function registerNewErrand() external {}
    function updateErrandStatus() external {}

    /* >>>>>>>> internal functions <<<<<<< */
}
