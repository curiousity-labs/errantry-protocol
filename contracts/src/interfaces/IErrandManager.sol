// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {Lib} from "../libraries/Lib.sol";

interface IErrandManager {
    function getErrand(
        uint256 errandId
    ) external view returns (Lib.Errand memory);

    function updateErrandRunner(uint256 errandId, address runner) external;

    function postNewErrand(Lib.PostNewErrandParams calldata params) external;
}
