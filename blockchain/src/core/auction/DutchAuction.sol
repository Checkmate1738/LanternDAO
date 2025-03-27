// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Events,Errors} from "@src/common/Events&Errors.sol";
import {IDutchAuction} from "@src/interfaces/IDutchAuction.sol";
import {BaseAuction} from "./BaseAuction.sol";

contract DutchAuction is BaseAuction,IDutchAuction {
    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : DUTCH AUCTION");

    function verify(bytes32 _verify) external pure returns(bool) {
        return _verify == CONTRACT_SIG;
    }
}