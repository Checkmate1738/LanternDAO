// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAuctionFactory {

    enum adminFunc {
        setFee,
        setFeeCollector
    }

    enum AuctionType {
        English_auction,
        Dutch_auction,
        SealedBid_auction,
        Vickery_auction
    }

    enum AuctionState {
        Active,
        Archived
    }

    struct  AdminFunc {
        adminFunc _func;
        bytes _data;
    }

    struct Auction {
        uint256 _index;
        address _auctioneer;
        address _currency;
        AuctionType _type;
        AuctionState _state;
        uint256 _timeCreated;
        uint256 _expiry;
    }


    function categories() external view returns(string[] memory _categories);

    function categoryAuctions(AuctionType _type) external view returns(Auction[] memory _auctions);

    function ActiveAuctions() external view returns(Auction[] memory _active);

    function ArchivedAuctions() external view returns(Auction[] memory _archived);

    function createAuction(AuctionType _type, address auctioneer, address _nftAddress, uint256 _nftAssets, address _currency, uint256 initialPrice, uint256 _expiry, bool defaultCurrency) external returns(address _auction);

    function archiveAuction(address _auction) external returns(bool);

    function verify(bytes32 _verify) external view returns(bool);
    
}