// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVickeryAuction {
    function verify(bytes32 _verify) external view returns(bool);
}