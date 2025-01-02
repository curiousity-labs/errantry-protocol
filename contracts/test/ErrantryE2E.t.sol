// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./mocks/MockEntryPoint.sol";
import {MockERC20} from "./mocks/MockERC20.sol";
import {Errantry} from "../src/Errantry.sol";
import {IErrantry} from "../src/interfaces/IErrantry.sol";
import {IErrandManager} from "../src/interfaces/IErrandManager.sol";
import {ErrantryClientSmartAccount} from "../src/ErrantryClientSmartAccount.sol";
import "forge-std/Test.sol";

contract ErrantryE2ETest is Test {
    // Contracts
    MockEntryPoint private mockEntryPoint;
    MockERC20 private mockToken;
    Errantry private errantry;

    // Addresses
    address private oracle = address(0xACE0); // Trusted Oracle
    address private client = vm.addr(1);
    address private runner = vm.addr(2);

    // Test Data
    uint256 private expires = block.timestamp + 1 days;
    uint256 private errandAmount = 1000;

    function setUp() public {
        // Deploy MockEntryPoint and MockToken
        mockEntryPoint = new MockEntryPoint();
        mockToken = new MockERC20("MockToken", "MKT", 18);

        // Deploy Errantry contract
        errantry = new Errantry(mockEntryPoint, oracle);

        // Register Client
        vm.prank(client);
        errantry.registerNewClient(client);
    }

    function testEndToEndFlow() public {
        // Step 1: Post a new errand
        vm.startPrank(oracle);
        IErrantry.PostNewErrandParams memory params = IErrantry.PostNewErrandParams({
            client: client,
            expires: expires,
            tokenAddress: address(mockToken),
            amount: errandAmount
        });
        errantry.postNewErrand(params);

        // Step 2: Assign a runner
        errantry.updateErrandRunner(0, client, runner);

        // Step 3: Mark the errand as complete
        errantry.markErrandAsComplete(0, client);
        vm.stopPrank();

        // Step 4: Simulate user operation for payment
        address errandManagerAddr = errantry.getErrandManagerAddress(client);
        IErrandManager errandManager = IErrandManager(errandManagerAddr);

        vm.startPrank(oracle);
        address smartAccount = errandManager.getClientSmartAccountAddress();
        ErrantryClientSmartAccount smartAccountContract = ErrantryClientSmartAccount(payable(smartAccount));

        // Mint tokens to the client for payments
        mockToken.mint(smartAccount, errandAmount * 10);

        // Mark the errand as paid
        smartAccountContract.payErrands(errandManager);

        vm.stopPrank();

        // Step 5: Verify payment was successful
        uint256 runnerBalance = mockToken.balanceOf(runner);
        assertEq(runnerBalance, errandAmount, "Runner should receive the payment");

        IErrandManager.Errand memory errand = errandManager.getErrand(0);
        assertEq(errand.status, 3, "Errand status should indicate 'paid'");

        // Step 6: Verify client's balance decreased
        uint256 clientBalance = mockToken.balanceOf(smartAccount);
        assertEq(clientBalance, errandAmount * 9, "Client's balance should decrease by errand amount");
    }
}
