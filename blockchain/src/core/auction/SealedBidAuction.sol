// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Events,Errors} from "@src/common/Events&Errors.sol";
import {ISealedBidAuction} from "@src/interfaces/ISealedBidAuction.sol";
import {BaseAuction} from "./BaseAuction.sol";

contract SealedBidAuction is BaseAuction,ISealedBidAuction {
    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : SEALED BID AUCTION");

    function verify(bytes32 _verify) external pure returns(bool) {
        return _verify == CONTRACT_SIG;
    }
}