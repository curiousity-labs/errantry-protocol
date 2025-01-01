// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {MockEntryPoint} from "./mocks/MockEntryPoint.sol";
import {Errantry} from "../src/Errantry.sol";
import {IErrandManager} from "../src/interfaces/IErrandManager.sol";
import {IErrantry} from "../src/interfaces/IErrantry.sol";
import {OnlyOracle} from "../src/OnlyOracle.sol";
import "forge-std/Test.sol";

contract ErrandManagerTest is Test {
    // Contracts
    MockEntryPoint private mockEntryPoint;
    Errantry private errantry;

    // Addresses
    address private oracle = address(0xACE0); // Trusted Oracle
    address private client = vm.addr(1);
    address private unauthorized = vm.addr(2);
    address private runner = vm.addr(3);

    // Test Data
    uint256 private expires = block.timestamp + 1 days;
    address private token = vm.addr(4);
    uint256 private amount = 1000;

    function setUp() public {
        // Deploy MockEntryPoint
        mockEntryPoint = new MockEntryPoint();

        // Deploy Errantry
        errantry = new Errantry(mockEntryPoint, oracle);

        // Register Client
        vm.prank(client);
        errantry.registerNewClient(client);
    }

    function testPostNewErrand_Success() public {
        vm.startPrank(oracle); // Simulate Oracle
        IErrantry.PostNewErrandParams memory params =
            IErrantry.PostNewErrandParams({client: client, expires: expires, tokenAddress: token, amount: amount});

        errantry.postNewErrand(params);
        vm.stopPrank();

        // Verify errand was posted
        address errandManagerAddr = errantry.getErrandManagerAddress(client);
        IErrandManager errandManager = IErrandManager(errandManagerAddr);

        IErrandManager.Errand memory errand = errandManager.getErrand(0);
        assertEq(errand.paymentToken.tokenAddress, token, "Token mismatch");
        assertEq(errand.paymentToken.amount, amount, "Amount mismatch");
        assertEq(errand.runner, address(0), "Runner mismatch");
    }

    function testUpdateErrandRunner_Success() public {
        // Post a new errand
        vm.startPrank(oracle); // Simulate Oracle
        IErrantry.PostNewErrandParams memory params =
            IErrantry.PostNewErrandParams({client: client, expires: expires, tokenAddress: token, amount: amount});
        errantry.postNewErrand(params);
        vm.stopPrank();

        // Update the runner
        vm.startPrank(oracle);
        errantry.updateErrandRunner(0, client, runner);
        vm.stopPrank();

        // Verify runner update
        address errandManagerAddr = errantry.getErrandManagerAddress(client);
        IErrandManager errandManager = IErrandManager(errandManagerAddr);

        IErrandManager.Errand memory errand = errandManager.getErrand(0);
        assertEq(errand.runner, runner, "Runner mismatch after update");
    }

    function testUnauthorizedAccess_Fails() public {
        vm.startPrank(unauthorized);

        // Attempt to post an errand - should fail
        IErrantry.PostNewErrandParams memory params =
            IErrantry.PostNewErrandParams({client: client, expires: expires, tokenAddress: token, amount: amount});
        vm.expectRevert(OnlyOracle.OnlyTrustedOracle.selector);
        errantry.postNewErrand(params);

        // Attempt to update a runner - should fail
        vm.expectRevert(OnlyOracle.OnlyTrustedOracle.selector);
        errantry.updateErrandRunner(0, client, runner);

        vm.stopPrank();
    }

    function testMarkErrandCompleteAndCancel() public {
        // Post an errand
        vm.startPrank(oracle);
        IErrantry.PostNewErrandParams memory params =
            IErrantry.PostNewErrandParams({client: client, expires: expires, tokenAddress: token, amount: amount});
        errantry.postNewErrand(params);
        vm.stopPrank();

        // Mark as complete
        vm.startPrank(oracle);
        errantry.markErrandAsComplete(0, client);
        vm.stopPrank();

        // Verify errand completion
        address errandManagerAddr = errantry.getErrandManagerAddress(client);
        IErrandManager.Errand memory errand = IErrandManager(errandManagerAddr).getErrand(0);
        assertEq(errand.status, 1, "Errand status should indicate completion");

        // Attempt to cancel should fail
        vm.startPrank(oracle);
        vm.expectRevert(IErrandManager.ErrandAlreadyCompleted.selector);
        errantry.cancelErrand(0, client);
        vm.stopPrank();
    }
}
