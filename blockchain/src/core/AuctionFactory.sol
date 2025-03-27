// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Events,Errors} from "@src/common/Events&Errors.sol";
import {IAuctionFactory} from "@src/interfaces/IAuctionFactory.sol";
import {IFeeCollector} from "@src/interfaces/IFeeCollector.sol";
import {ILantern} from "@src/interfaces/ILantern.sol";
import {ITreasury} from "@src/interfaces/ITreasury.sol";
import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import {Verify} from "@src/common/Verify.sol";

abstract contract AuctionFactory is IAuctionFactory {
    // state variables

    uint256 internal constant MAX_FEE = 10_000; // 100% = 10_000
    uint256 internal fee = 50; // default = 0.5%

    address[] internal whitelisted;
    address internal immutable admin;
    address internal feeCollector;

    IERC20 internal immutable defaultCurrency;
    IERC20 internal currency;
    ITreasury internal treasury;

    bytes32 internal constant CONTRACT_SIG = keccak256("LANTERN : AUCTION FACTORY");

    bool internal feeActive;

    // Mapping

    mapping(AuctionType _type => Auction[] auctions) internal category;
    mapping(AuctionState _state => Auction[] auctions) internal auctionState;
    mapping(address _address => Auction _auction) internal auction;
    mapping(address _token => uint256 _fees) internal totalFees;

    // Modifiers

    modifier onlyAdmin() {
        if (msg.sender != admin){
            revert Errors.Unauthorized_Access();
        }
        _;
    }

    modifier onlyFeeCollector() {
        if (msg.sender != feeCollector){
            revert Errors.Unauthorized_Access();
        }
        _;
    }

    modifier _update() {
        whitelisted = treasury.supportedTokens();
        _;
    }

    constructor(address _feeCollector, address _defaultCurrency, address _treasury ) {
        if (!IFeeCollector(_feeCollector).verify(Verify.FEE_COLL_SIG)) revert Errors.Invalid_Lantern_Contract();

        if(!ILantern(_defaultCurrency).verify(Verify.LANTERN_SIG)) revert Errors.Invalid_Lantern_Contract();
        
        if(!ITreasury(_treasury).verify(Verify.TREASURY_SIG)) revert Errors.Invalid_Lantern_Contract();

        defaultCurrency = IERC20(_defaultCurrency);
        feeCollector = _feeCollector;
        treasury = ITreasury(_treasury);
        admin = msg.sender;

        whitelisted = treasury.supportedTokens();
    }


    // External functions

    function createAuction(AuctionType _type, address auctioneer, address _nftAddress, uint256 _nftAssets, address _currency, uint256 initialPrice, uint256 _expiry, bool _defaultCurrency) _update external returns(address _auction) {

        if(!_defaultCurrency){
           _auction =  _createAuctionWithCustom(_type, auctioneer, _nftAddress, _nftAssets, _currency, initialPrice, _expiry);
        }

        _auction = _createAuctionWithDefault(_type, auctioneer, _nftAddress, _nftAssets, initialPrice, _expiry);
    }

    function archiveAuction(address _auctionAddress) _update external returns(bool){
        Auction memory _auction = auction[_auctionAddress];

        if ((_auction._expiry + _auction._timeCreated) <= block.timestamp) revert Errors.Expiry_Time_Not_Yet_Reached();

        Auction[] storage auctionsAc = auctionState[AuctionState.Active];
        Auction[] storage auctionsAr = auctionState[AuctionState.Archived];
        uint256 limitAc = auctionsAc.length;
        uint256 limitAr = auctionsAr.length;
        Auction storage initial = auctionsAc[_auction._index];
        Auction storage last = auctionsAc[limitAc-1];

        (initial,last) = (last,initial);

        auctionsAc.pop();

        _auction._index = limitAr;
        _auction._state = AuctionState.Archived;

        auctionsAr.push(_auction);

        return true;

    }

    function setFeeCollector(address _feeCollector) onlyAdmin external returns(bool){
        if (feeActive){
            revert Errors.Clear_Fees();
        }

        if (!IFeeCollector(_feeCollector).verify(Verify.FEE_COLL_SIG)) revert Errors.Invalid_Lantern_Contract();

        feeCollector = _feeCollector;
        return true;
    }

    /// 100% = 10_000
    function setFees(uint256 _feeInBPS) onlyAdmin external returns(bool){
        fee = _feeInBPS;
        feeActive = true;
        return true;
    }

    function collectFees() _update onlyFeeCollector external returns(bool){
        for (uint256 i; i< whitelisted.length;++i){
            currency = IERC20(whitelisted[i]);
            uint256 balance = totalFees[whitelisted[i]];

            totalFees[whitelisted[i]] = 0;

            currency.transfer(feeCollector, balance);

            currency = IERC20(address(0));
            balance = 0;
        }

        feeActive = false;
        return true;
    }

    // View functions

    function categories() external pure returns(string[] memory _categories){
    
        _categories = new string[](4);

        _categories[0] = "English";
        _categories[1] = "Dutch";
        _categories[2] = "Sealed-Bid";
        _categories[3] = "Vickery";
        
    }

    function categoryAuctions(AuctionType _type) external view virtual returns(Auction[] memory _auctions) {
        _auctions = category[_type];
    }

    function ActiveAuctions() external view returns(Auction[] memory _active){
        _active = auctionState[AuctionState.Active];
    }

    function ArchivedAuctions() external view returns(Auction[] memory _archived){
        _archived = auctionState[AuctionState.Archived];
    }

    // Internal functions

    function _createAuctionWithDefault(AuctionType _type, address auctioneer, address _nftAddress, uint256 _nftAssets, uint256 initialPrice, uint256 _expiry) internal virtual returns(address _auction);

    function _createAuctionWithCustom(AuctionType _type, address auctioneer, address _nftAddress, uint256 _nftAssets, address _currency, uint256 initialPrice, uint256 _expiry) internal virtual returns(address _auction);

    // Admin and authentication functions

    function adminFunction(AdminFunc memory _func) external virtual;

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