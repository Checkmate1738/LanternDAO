// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Events,Errors} from "@src/common/Events&Errors.sol";
import {IEnglishAuction} from "@src/interfaces/IEnglishAuction.sol";
import {BaseAuction} from "./BaseAuction.sol";

contract EnglishAuction is BaseAuction,IEnglishAuction {
    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : ENGLISH AUCTION");

    function verify(bytes32 _verify) external pure returns(bool) {
        return _verify == CONTRACT_SIG;
    }
}