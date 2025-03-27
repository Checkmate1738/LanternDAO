// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Events,Errors} from "@src/common/Events&Errors.sol";
import {IVickeryAuction} from "@src/interfaces/IVickeryAuction.sol";
import {BaseAuction} from "./BaseAuction.sol";

contract VickeryAuction is BaseAuction,IVickeryAuction {
    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : VICKERY AUCTION");

    function verify(bytes32 _verify) external pure returns(bool) {
        return _verify == CONTRACT_SIG;
    }
}