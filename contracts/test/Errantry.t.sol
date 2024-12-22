// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "../lib/forge-std/src/Test.sol";
import "../src/Errantry.sol";
import "../src/interfaces/IErrandManager.sol";
import "../src/libraries/Lib.sol";
import "../src/mocks/MockERC20.sol";

contract ErrantryTest is Test {
    Errantry public errantry;
    MockERC20 public paymentToken;

    function setUp() public {
        // Deploy Errantry and MockERC20 for tests
        errantry = new Errantry();
        paymentToken = new MockERC20("Mock Token", "MCK", 18);
    }

    function testRegisterNewClient() public {
        address client = address(1);

        // Use prank to impersonate the client for testing
        vm.prank(client);
        errantry.registerNewClient();

        (address registeredClient, , ) = errantry.clients(client);

        assertEq(
            registeredClient,
            client,
            "Client should be registered correctly"
        );
    }

    function testRegisterNewClientFailsForDuplicate() public {
        address client = address(1);

        // First registration should succeed
        vm.prank(client);
        errantry.registerNewClient();

        // Check that the client is registered
        (address registeredClient, , ) = errantry.clients(client);
        assertEq(
            registeredClient,
            client,
            "Client should be registered correctly"
        );

        // Expect a revert when trying to register the same client again
        vm.prank(client);
        vm.expectRevert(Errantry.ClientAlreadyRegistered.selector);
        errantry.registerNewClient();

        // Verify state hasn't changed after the failed attempt
        (registeredClient, , ) = errantry.clients(client);
        assertEq(registeredClient, client, "Client should still be registered");
    }

    function testPostNewErrand() public {
        address client = address(1);

        // Register the client
        vm.prank(client);
        errantry.registerNewClient();

        // Create params for posting a new errand
        Lib.PostNewErrandParams memory params = Lib.PostNewErrandParams({
            errandId: 1,
            client: client,
            expires: block.timestamp + 1 weeks,
            paymentToken: Lib.PaymentToken({
                tokenAddress: address(paymentToken),
                amount: 100 ether
            })
        });

        // Post a new errand as the client
        vm.prank(client);
        errantry.postNewErrand(params);

        // Verify that the errand was stored correctly
        (, IErrandManager errandManager, ) = errantry.clients(client);
        address storedPaymentToken = errandManager
            .getErrand(1)
            .paymentToken
            .tokenAddress;

        assertEq(
            storedPaymentToken,
            address(paymentToken),
            "Payment token address mismatch"
        );
    }
}
