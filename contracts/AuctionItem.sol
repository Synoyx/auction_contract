// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

struct AuctionItem {
    string itemName;

    int256 auctionStartValue;
    int256 auctionStep;
    int256 auctionReservePrice;

    // Address of the owner
    address ownerAddress;

    // Timestamp for the end date of the auction for this item
    uint auctionEndDate;
}