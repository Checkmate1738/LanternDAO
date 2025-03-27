// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Events,Errors} from "@src/common/Events&Errors.sol";
import {ILantern} from "@src/interfaces/ILantern.sol";
import {ITreasury} from "@src/interfaces/ITreasury.sol";
import {Verify} from "@src/common/Verify.sol";

contract Lantern is ERC20,ILantern {

    ITreasury internal immutable treasury;

    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : DEFAULT CURRENCY");

    modifier onlyTreasury() {
        if (msg.sender != address(treasury)) revert Errors.Unauthorized_Access();
        _;
    }

    constructor(address _treasury) ERC20("LANTERN","LANT") {
        if (!ITreasury(_treasury).verify(Verify.TREASURY_SIG)){
            revert Errors.Invalid_Lantern_Contract();
        }

        treasury = ITreasury(_treasury);
    }

    function generate(uint256 amount) onlyTreasury external {
        _mint(msg.sender, amount);
        uint256 balance = balanceOf(msg.sender);
        emit Events.New_Lanterns_Generated(amount,balance);
    }

    function shred(uint256 amount) onlyTreasury external {
        _burn(msg.sender, amount);
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