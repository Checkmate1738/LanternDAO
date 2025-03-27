// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITreasury {
    function supportedTokens() external view returns(address[] memory);
    
    function verify(bytes32 _verify) external view returns(bool);
}