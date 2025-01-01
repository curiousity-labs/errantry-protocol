// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {IEntryPoint} from "@account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {IErrantry} from "../src/interfaces/IErrantry.sol";
import {Errantry} from "../src/Errantry.sol";
import {MockEntryPoint} from "./mocks/MockEntryPoint.sol";
import "forge-std/Test.sol";

contract ErrantryRegistrationTest is Test {
    // Contracts
    Errantry private errantry;
    MockEntryPoint private mockEntryPoint;

    // Addresses
    address private oracle = address(0xACE0); // pretend this is your trusted oracle
    address private alice = address(0xA11CE);
    address private bob = address(0xB0B);

    function setUp() public {
        // Deploy a mock EntryPoint
        mockEntryPoint = new MockEntryPoint();

        // Deploy Errantry with the mock entry point + set `oracle`
        errantry = new Errantry(IEntryPoint(address(mockEntryPoint)), oracle);
    }

    function testRegisterNewClient_Success() public {
        // By default, msg.sender in Foundry is address(this), so we can prank to simulate calls
        vm.prank(alice);
        errantry.registerNewClient(alice); // or pass some other param if your design changed

        bool isRegistered = errantry.isClientRegistered(alice);
        assertTrue(isRegistered, "Client should be registered");
    }

    function testRegisterNewClient_FailsIfAlreadyRegistered() public {
        // Register once
        vm.prank(alice);
        errantry.registerNewClient(alice);

        // Try registering again
        vm.startPrank(alice);
        vm.expectRevert(IErrantry.ClientAlreadyRegistered.selector);
        errantry.registerNewClient(alice);
        vm.stopPrank();
    }

    function testIsClientRegistered_ReturnsFalseIfNotRegistered() public view {
        bool isRegistered = errantry.isClientRegistered(bob);
        assertFalse(isRegistered, "Client should not be registered yet");
    }
}
