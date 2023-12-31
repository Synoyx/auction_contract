// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

import "contracts/AuctionItem.sol";
import "contracts/Bidder.sol";

/**
* Contract to manage bid about a precise object
**/
contract AuctionItemContract {
    /**************************
    *        Variables
    **************************/
    // Test, the idea is to have 1 smart contract / item of the same auction
    uint public auctionId;

    // We ensure that the only person who can end the auction is his creator
    address auctionOwner;

    // We only keep the highest bidder infos
    Bidder public highestBidder;

    // The auction item and his price infos
    AuctionItem public auctionItem;


    /**************************
    *          Events
    **************************/

    event ActionEnded(bool isItemSold, int highestBidValue);
    event HighestBidIncreased(int newHighestBidValue);


    /**************************
    *        Functions
    **************************/

    constructor(AuctionItem memory _auctionItem) {
        // Storing the creator of the auction for this item
        auctionOwner = msg.sender;

        auctionItem = _auctionItem;
    }

    // Allows anyone to bid as long as the auction hasn't ended yet
    function bid() public payable {
        // We verify that the auction is still running
        require(block.timestamp < auctionItem.auctionEndDate, "Auction is ended, you can't bid anymore");
        // Ensure that the bid price is higher than the last one (and take the step price in account)
        require(msg.value > uint(highestBidder.bidValue + auctionItem.auctionStep), "You didn't bid enough !");

        // Withdrawing the last bidder coins
        payable(highestBidder.bidderAddress).transfer(uint(highestBidder.bidValue));

        //Storing infos on new highest bidder
        highestBidder.bidValue = int256(msg.value);
        highestBidder.bidderAddress = msg.sender;

        emit HighestBidIncreased(highestBidder.bidValue);
    }

    // Function that can only be called by the owner of the auction
    // Will transfer the auction value to the item owner
    function endAuction() public payable {
        require(msg.sender == auctionOwner, "You're not the auction owner, you can't end it");
        require(block.timestamp >= auctionItem.auctionEndDate, "Auction not yet ended");

        bool itemSold = true;

        if (highestBidder.bidValue < auctionItem.auctionReservePrice) {
            // Giving back to the highest bidder his bid
            payable(highestBidder.bidderAddress).transfer(uint(highestBidder.bidValue));

            console.log("The auction has'nt reach the reserve price, the bidder has been refunded");
            itemSold = false;
        } else {
            payable(auctionItem.ownerAddress).transfer(uint(highestBidder.bidValue));
        }

        emit ActionEnded(itemSold, highestBidder.bidValue);
    }


    /**************************
    *        Modifiers
    **************************/
}