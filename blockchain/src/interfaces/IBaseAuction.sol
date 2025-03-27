// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBaseAuction {

    enum State {
        Created,
        Active,
        Ended,
        Canceled
    }

    struct Bid {
        address _who;
        uint256 _nftId;
        uint256 _bid;
    }

    struct Asset {
        address _nftAddress;
        uint256 _initialValue;
        uint256 _startingBid;
        string _descrption;
        State _status;
    }

    struct Auction {
        address auctioneer;
        Asset[] _assets;
        uint256 _launchedAt;
        uint256 _expiry;
        bytes32 _type;
    }
}