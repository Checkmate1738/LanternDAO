// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";

interface ILanternVotes is IERC20 {

    function initialize(address _shares) external returns(bool);

    function generate(address account, uint256 value, address _currency) external returns(bool);

    function revoke(address account, uint256 value) external returns(bool);

    function shred(uint256 amount) external returns(bool);

    function verify(bytes32 _verify) external view returns(bool);
}