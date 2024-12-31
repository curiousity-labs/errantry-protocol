// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IErrandManager {
    struct PaymentToken {
        address tokenAddress;
        uint256 amount;
    }

    struct Errand {
        uint256 errandId;
        PaymentToken paymentToken;
        address runner;
        uint256 expires;
        uint8 status;
    }

    event ErrandPosted(
        uint256 indexed errandId,
        address indexed client,
        address indexed runner,
        address paymentToken,
        uint256 paymentAmount,
        uint256 expires
    );

    event ErrandRunnerUpdated(uint256 indexed errandId, address indexed runner);
    event ErrandCompleted(uint256 indexed errandId);
    event ErrandPaid(uint256 indexed errandId);
    event ErrandCancelled(uint256 indexed errandId);

    error ErrandAlreadyCompleted();
    error ErrandNotCompleted();
    error ErrandNotPaid();
    error ErrandAlreadyPaid();
    error ErrandAlreadyCancelled();
    error MustBeClientSmartAccount();

    function postNewErrand(address client, uint256 expires, address tokenAddress, uint256 amount) external;

    function updateErrandRunner(uint256 errandId, address runner) external;

    function markErrandAsComplete(uint256 errandId) external;

    function markErrandAsPaid(uint256 errandId) external;

    function cancelErrand(uint256 errandId) external;

    function getUnPaidErrands() external view returns (Errand[] memory);

    function getClientSmartAccountAddress() external view returns (address);
}
