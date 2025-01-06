// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableAuction {
    address public highestBidder;
    uint256 public highestBid;

    // Place a bid in the auction
    function placeBid() public payable {
        require(msg.value > highestBid, "Bid is too low");

        // Refund the previous highest bidder
        if (highestBid > 0) {
            (bool success, bytes memory data) = payable(highestBidder).call{value: highestBid}("");
        }

        // Update the highest bid and bidder
        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}
