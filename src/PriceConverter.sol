// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter{
    function getPrice(AggregatorV3Interface priceFeed) internal  view returns(uint256) {
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        //AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        (,int256 answer,,,)=priceFeed.latestRoundData();
        
         // ETH/USD rate in 18 digit
         //WE ADDED 10 ZEROS TO GET RETURN WALUE IN 18 DIGIT
        return uint256(answer*10000000000);

    }

    //ethAmount IS RECEIVED AS WEI SO IT HOLDS 10**18
    function getConversionRate( uint256 ethAmount,AggregatorV3Interface priceFeed) internal view returns(uint256) {
        uint256 ethPrice=getPrice(priceFeed);
        
        //ethPrice  10**18 * ethAmount 10**18
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.

        return  ethAmountInUsd; //WE RETURN ethAmountInUsd WITH  10**18
    }
}