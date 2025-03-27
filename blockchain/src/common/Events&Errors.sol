// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Events {

    event Lantern_Contract_Deployed();
    event Auction_created(address indexed _auctionAddress, address auctioneer, string _type, uint256 _expiry);
    event Auction_archived(address indexed _auctionAddress, string _type);
    event Set_Fees(uint256 _fees);
    event New_Lanterns_Generated(uint256 amount,uint256 totalAmount);
}

library Errors {

    error Auction_creation_Failed();
    error Auction_archive_Failed();
    error Set_Fees_Failed();
    error Unauthorized_Access();
    error Invalid_Lantern_Contract();
    error Clear_Fees();
    error Expiry_Time_Not_Yet_Reached();
    error This_Contract_Does_Not_Receive_Ether();
    error No_Function_Assigned_To_The_Signature_Provided();

}