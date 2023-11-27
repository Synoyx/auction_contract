// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

import "hardhat/console.sol";

import "contracts/AuctionItem.sol";
import "contracts/AuctionItemContract.sol";

import "@openzeppelin/contracts/utils/Strings.sol";

/**
* Contract to manage an auction, compose of multiple objects
**/
contract AuctionContract {
    /**************************
    *        Variables
    **************************/
    // We ensure that the only person who can end the auction is his creator
    address auctionOwner;

    // List of auction items
    AuctionItem[] auctionItems;
    
    mapping (AuctionItemContract => AuctionItem) contractItemsMap;


    /**************************
    *          Events
    **************************/

    event StartAuctionForItem(string itemName, int auctionStartPrice, int auctionStepPrice);

    /**************************
    *        Functions
    **************************/

    constructor(AuctionItem[] memory _auctionItems) {
        // We can't direcly give the argument value to the array,
        // otherwise we have an error
        for (uint i = 0; i < _auctionItems.length; i++) {
            auctionItems.push(_auctionItems[i]);
        }
    }

    function startAuction() public {
        for (uint i = 0; i < auctionItems.length; i++) {
            emit StartAuctionForItem(auctionItems[i].itemName, auctionItems[i].auctionStartValue, auctionItems[i].auctionStep);

            // Creating a auction contract for the current item, and storing it
            AuctionItemContract itemContract = new AuctionItemContract(auctionItems[i]);
            contractItemsMap[itemContract] = auctionItems[i];
        }
    }

    function logAuctions() public view {
        for (uint i = 0; i < auctionItems.length; i++) {
            console.log(string.concat("Item name = ", auctionItems[i].itemName, ",  item start price : ", Strings.toString(uint(auctionItems[i].auctionStartValue))));
        }
    }


    /**************************
    *        Modifiers
    **************************/
}