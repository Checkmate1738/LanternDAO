// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

interface ILantern is IERC20{
    function verify(bytes32 _verify) external view returns(bool);
}