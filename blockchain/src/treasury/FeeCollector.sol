// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {IFeeCollector} from "@src/interfaces/IFeeCollector.sol";
import {Events,Errors} from "@src/common/Events&Errors.sol";
import {Treasury} from "./Treasury.sol";

contract FeeCollector is IFeeCollector {
    using Address for address;

    bytes32 internal constant CONTRACT_SIG= keccak256("LANTERN : FEE COLLECTOR");

    address internal immutable admin;

    modifier onlyOwner() {
        require(msg.sender == admin, "Invalid acces");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function collectFees(address[] calldata _contract,bytes[] calldata _data) onlyOwner external returns(bool) {
        require(_contract.length == _data.length, "Invalid batch operation");

        for (uint256 i; i<_contract.length; ++i){
            Address.functionCall(_contract[i], _data[i]);
        }
        return true;
    }

    function verify(bytes32 _verify) external pure returns(bool){
        return _verify == CONTRACT_SIG;
    }

    fallback() external payable {
        revert Errors.No_Function_Assigned_To_The_Signature_Provided();
    }

    receive() external payable {
        revert Errors.This_Contract_Does_Not_Receive_Ether();
    }
}