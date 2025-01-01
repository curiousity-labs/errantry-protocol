// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract OnlyOracle {
    address internal TRUSTED_ORACLE;

    error OnlyTrustedOracle();

    constructor(address _trustedOracle) {
        TRUSTED_ORACLE = _trustedOracle;
    }

    modifier onlyOracle() {
        require(msg.sender == TRUSTED_ORACLE, OnlyTrustedOracle());
        _;
    }
}
