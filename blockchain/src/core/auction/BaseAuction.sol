// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Events,Errors} from "@src/common/Events&Errors.sol";
import {IBaseAuction} from "@src/interfaces/IBaseAuction.sol";

abstract contract BaseAuction is IBaseAuction {

    fallback() external payable {
        revert Errors.No_Function_Assigned_To_The_Signature_Provided();
    }

    receive() external payable {
        revert Errors.This_Contract_Does_Not_Receive_Ether();
    }
}