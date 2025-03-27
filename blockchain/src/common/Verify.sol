// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Verify {

    bytes32 constant LANTERN_SIG = keccak256("LANTERN : DEFAULT CURRENCY");

    bytes32 constant BASE_AUC_SIG = keccak256("LANTERN : BASE AUCTION");

    bytes32 constant ENG_AUC_SIG = keccak256("LANTERN : ENGLISH AUCTION");

    bytes32 constant DUTCH_AUC_SIG = keccak256("LANTERN : DUTCH AUCTION");

    bytes32 constant SEALED_AUC_SIG = keccak256("LANTERN : SEALED BID AUCTION");

    bytes32 constant VICK_AUC_SIG = keccak256("LANTERN : VICKERY AUCTION");

    bytes32 constant AUC_FACT_SIG = keccak256("LANTERN : AUCTION FACTORY");

    bytes32 constant FEE_COLL_SIG = keccak256("LANTERN : FEE COLLECTOR");

    bytes32 constant TREASURY_SIG = keccak256("LANTERN : TREASURY");

    bytes32 constant LANTERN_VOTES_SIG = keccak256("LANTERN : LANTERN VOTES");

    bytes32 constant SHARES_SIG = keccak256("LANTERN : SHARE HOLDINGS");


    bytes32 constant PLATINUM_SIG = keccak256("LANTERN : PLATINUM SHARES");

    bytes32 constant FOUNDER_SIG = keccak256("LANTERN : FOUNDER SHARES");

    bytes32 constant DIRECTOR_SIG = keccak256("LANTERN : DIRECTOR SHARES");

    bytes32 constant NOVICE_SIG = keccak256("LANTERN : NOVICE SHARES");

    bytes32 constant CLASSIC_SIG = keccak256("LANTERN : CLASSIC SHARES");

    bytes32 constant ROYAL_SIG = keccak256("LANTERN : ROYAL SHARES");

}