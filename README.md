![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white) ![Ethereum](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white)

## auction_contract

<h4>An implementation of auctions built on an ETH based blockchain with smart contracts.</h4>

<h3>How it works ?</h3>

- Call the AuctionContract by giving all the auction items details
- Start the auction by using "startAuction()" of AuctionContract. It'll create a smart contract for each items specified on step 1, allowing bidders to bid for their favorite items
- You can call "listContracts()" to show contract address for each auction item
- With the address, you can know interact with the AuctionItemContract.
- You can use "bid()" to place you bid. The price must be higher then the last higher bid + the step price value
- You can show the last higher bid with the "highestBidder" in the contract
- You can subscribe to the "HighestBidIncreased" event, to ensure that you won't miss the item
- Once the auction is done, the creator of the auction will end every smart contract. If you are the higher bidder for an object, and your bid is superior to the reserve price, you won the item. If you're the higher bidder but the reserve price wasn't reached, we'll pay you back your bid

<h3>How to use ?</h3>

<h4>The easier way to use the projet is by using Remix IDE</h4>
```
[https://remix.ethereum.org/]
```
<h4>You can clone the project there, then select "contracts/AuctionContract.sol" file, compile it and run it directly in Remix IDE.</h4>
