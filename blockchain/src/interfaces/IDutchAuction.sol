// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDutchAuction {
    function verify(bytes32 _verify) external view returns(bool);
}