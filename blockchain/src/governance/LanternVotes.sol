// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20Votes,ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {Events,Errors} from "@src/common/Events&Errors.sol";
import {Verify} from "@src/common/Verify.sol";
import {IShares} from "@src/interfaces/IShares.sol";

contract LanternVotes is ERC20Votes {

    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : LANTERN VOTES");
    uint256 internal constant MAX_FEE = 10_000;
    uint256 internal FEE = 500;// 5%

    IShares internal shares;
    bool internal initialized = false;

    mapping(address _currency => uint256 _fee) internal totalFees;

    modifier onlyShares() {
        if (msg.sender != address(shares)) revert Errors.Unauthorized_Access();
        _;
    }

    modifier Initialize() {
        require(initialized == false, "initialized");
        _;
    }

    constructor(uint256 value) EIP712("Lantern Votes","1") ERC20("Lantern Votes","L-Votes") {
        _mint(msg.sender, value);
    }

    function initialize(address _shares) Initialize external returns(bool){
        if (IShares(_shares).verify(Verify.SHARES_SIG)) revert Errors.Invalid_Lantern_Contract();

        initialized = true;
        shares = IShares(_shares);
        
        return true;
    }

    function generate(address account,uint256 value, address _currency) onlyShares external returns(bool) {
        require(account.code.length == 0,"No Smart Contracts allowed");

        uint256 _fee = (value * FEE)/MAX_FEE;

        uint256 _value = value - _fee;

        totalFees[_currency] = _fee;

        _mint(account, _value);
        _delegate(account, account);
        return true;
    }

    function revoke(address account, uint256 value) onlyShares external returns(bool) {
        require(account.code.length == 0, "No Smart Contracts allowed");
        require(balanceOf(account) >= value);
        
        require(transferFrom(account, address(shares), value), "Failed to transfer");

        return true;
    }

    function shred(uint256 amount) onlyShares external returns(bool) {
        _burn(msg.sender, amount);

        return true;
    }

    function verify(bytes32 _verify) external pure returns(bool){
        return _verify == CONTRACT_SIG;
    }
}