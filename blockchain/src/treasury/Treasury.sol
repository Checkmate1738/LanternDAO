// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ITreasury} from "@src/interfaces/ITreasury.sol";
import {ILantern} from "@src/interfaces/ILantern.sol";
import {Verify} from "@src/common/Verify.sol";
import {Events,Errors} from "@src/common/Events&Errors.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Treasury is Ownable,ITreasury {

    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : TREASURY");

    ILantern internal lantern;
    
    address[] internal whitelisted;

    mapping(address _token => uint256 _index) internal index;



    constructor() Ownable(msg.sender) {
        emit Events.Lantern_Contract_Deployed();
    }

    function setDefCurrency(address _defaultCurrency) onlyOwner external returns(bool) {
        if(ILantern(_defaultCurrency).verify(Verify.LANTERN_SIG)) revert Errors.Invalid_Lantern_Contract();

        lantern = ILantern(_defaultCurrency);
        return true;
    }

    function supportedTokens() external view returns(address[] memory){
        return whitelisted;
    }

    function _addWhitelisted(address _address) internal returns(bool) {
        index[_address] = whitelisted.length;
        whitelisted.push(_address);
        return true;
    }

    function _removeWhitelisted(address _address) internal returns(bool) {
        uint256 i = index[_address];
        address initial = whitelisted[i];
        address last = whitelisted[whitelisted.length - 1];

        if(initial != last) {
            (initial,last) = (last,initial);
        }

        whitelisted.pop();
        return true;
    }

    function verify(bytes32 _verify) external pure returns(bool) {
        return CONTRACT_SIG == _verify;
    }

    fallback() external payable {
        revert Errors.No_Function_Assigned_To_The_Signature_Provided();
    }

    receive() external payable {
        revert Errors.This_Contract_Does_Not_Receive_Ether();
    }
}