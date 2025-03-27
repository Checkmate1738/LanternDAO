// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20Votes} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {ILanternVotes} from "@src/interfaces/ILanternVotes.sol";
import {Verify} from "@src/common/Verify.sol";
import {Events,Errors} from "@src/common/Events&Errors.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Shares is ERC721 {

    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : SHARE HOLDINGS");

    ILanternVotes internal immutable lVotes;

    address internal immutable admin;

    // SHARES FOR FOUNDERS AND DIRECTORS
    uint256 internal constant FOUNDER_SHARES = 200_000;

    uint256 internal constant DIRECTOR_SHARES = 150_000;

    // SHARES FOR STAFF
    uint256 internal constant MAX_STAFF_SHARES = 139_900;

    uint256 internal constant MIN_STAFF_SHARES = 90_001;

    // MAXIMUM SHARES PER INDIVIDUAL { COMMUNITY } 1_000 - 90_000
    uint256 internal constant TOTAL_MAX_SHARES = 90_000;
    
    uint256 internal constant MAX_CLASSIC_SHARES = 49_999;
    
    uint256 internal constant MAX_NOVICE_SHARES = 19_999;

    // MINIMUM SHARES PER INDIVIDUAL { COMMUNITY }
    uint256 internal constant TOTAL_MIN_SHARES = 1_000;
    
    uint256 internal constant MIN_ROYAL_SHARES = 50_000;
    
    uint256 internal constant MIN_CLASSIC_SHARES = 20_000;

    uint256 internal tokenId;

    enum SHARE_SIG {
        PLATINUM,
        FOUNDER,//200_000 - 300_000
        DIRECTOR,//140_000 - 199_900
        STAFF,//90_000 - 139_900
        ROYAL,//50_000 - 89_999
        CLASSIC,//20_000 - 49_999
        NOVICE // 1_000 - 19_999
    }

    struct SHARE {
        uint256 _tokenId;
        uint256 _shares;
        bytes32 _verify;
        uint256 _index;
    }

    mapping(SHARE_SIG _sig => SHARE[] _shares) internal category;

    mapping(uint256 _tokenId => SHARE _share) internal share;

    modifier onlyAdmin() {
        require(msg.sender == admin,Errors.Unauthorized_Access());
        _;
    }

    modifier onlyOwner(uint256 _tokenId) {
        require(_tokenId <= tokenId, "Invalid tokenId");
        require(_ownerOf(_tokenId) == msg.sender, "Invalid access");
        _;
    }

    constructor(address _lVotes) ERC721("LANTERN SHARES","LSH") {

        if (ILanternVotes(_lVotes).verify(Verify.LANTERN_VOTES_SIG)) revert Errors.Invalid_Lantern_Contract();

        lVotes = ILanternVotes(_lVotes);
        
        SHARE memory _share_ = SHARE({
            _tokenId : tokenId,
            _shares : 100_000_000_000,
            _verify : keccak256("LANTERN : PLATINUM SHARES"),
            _index : category[SHARE_SIG.PLATINUM].length
        });
        
        category[SHARE_SIG.PLATINUM].push(_share_);

        share[tokenId] = _share_;

        admin = msg.sender;

        _mint(msg.sender, tokenId);
        tokenId++;
    }

    function buyShares(address _currency,uint256 amount) external returns(bool) {
        
        require(balanceOf(msg.sender) == 0, "Already have shares go to addShares");

        address _account = msg.sender;

        SHARE memory _share;

        require(amount <= TOTAL_MAX_SHARES && amount >= TOTAL_MIN_SHARES, "The amount provided is beyond/below the situated threshold.");

        require(lVotes.generate(_account, amount, _currency),"Error generating shares");

        uint256 balance = lVotes.balanceOf(_account);

        if (balance >= TOTAL_MIN_SHARES && balance < MAX_NOVICE_SHARES){
            _share = SHARE({
                _tokenId : tokenId,
                _shares : lVotes.balanceOf(_account),
                _verify : keccak256("LANTERN : NOVICE SHARES"),
                _index : category[SHARE_SIG.NOVICE].length
            });

            category[SHARE_SIG.NOVICE].push(_share);

            share[tokenId] = _share;
        }

        else if (balance >= MIN_CLASSIC_SHARES && balance < MAX_CLASSIC_SHARES){
            _share = SHARE({
                _tokenId : tokenId,
                _shares : lVotes.balanceOf(_account),
                _verify : keccak256("LANTERN : CLASSIC SHARES"),
                _index : category[SHARE_SIG.CLASSIC].length
            });

            category[SHARE_SIG.CLASSIC].push(_share);

            share[tokenId] = _share;
        }
        
        else if (balance >= MIN_ROYAL_SHARES && balance < TOTAL_MAX_SHARES){
            _share = SHARE({
                _tokenId : tokenId,
                _shares : lVotes.balanceOf(_account),
                _verify : keccak256("LANTERN : ROYAL SHARES"),
                _index : category[SHARE_SIG.ROYAL].length
            });

            category[SHARE_SIG.ROYAL].push(_share);

            share[tokenId] = _share;
        }

        _mint(_account,tokenId);
        tokenId++;

        return true;
    }

    function sellShares(uint256 _tokenId,uint256 amount) onlyOwner(_tokenId) external returns(bool) {
        address _account = msg.sender;

        require(amount <= TOTAL_MAX_SHARES && amount >= TOTAL_MIN_SHARES, "The amount provided is beyond/below the situated threshold.");

        SHARE storage _share = share[tokenId];

        require(amount <= _share._shares, "Amount beyond current shares");

        _share._shares = _share._shares - amount;

        if (_share._verify == Verify.ROYAL_SIG) {
            if (_share._shares < MIN_ROYAL_SHARES && _share._shares >= MIN_CLASSIC_SHARES){
                _share._verify = keccak256("LANTERN : CLASSIC SHARES");
            } 
            else if (_share._shares < MIN_CLASSIC_SHARES && _share._shares >= TOTAL_MIN_SHARES) {
                _share._verify = keccak256("LANTERN : NOVICE SHARES");
            }
        }
        else if (_share._verify == Verify.CLASSIC_SIG && _share._shares < MIN_CLASSIC_SHARES && _share._shares >= TOTAL_MIN_SHARES) {
            _share._verify = keccak256("LANTERN : NOVICE SHARES");
        }
        else if (_share._verify == Verify.NOVICE_SIG && _share._shares < TOTAL_MIN_SHARES) {
            amount = amount + _share._shares;
            _share._shares = 0;
        }

        require(lVotes.revoke(_account, amount),"Error revoking shares check if approved.");

        return true;
    }

    function myShares(uint256 _tokenId) onlyOwner(_tokenId) external view returns(SHARE memory _share) {
        _share = share[_tokenId];
    }

    function burn(uint256 amount) onlyAdmin external returns(bool) {
        require(lVotes.shred(amount),"Error burning voting tokens");

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