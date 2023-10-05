// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

import {DevOpsTools} from "foundry-devops/DevOpsTools.sol";


contract FundFundMe is Script {
    uint256 SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    //run je za forge script scripts/Interactions.s.sol --rpc-url itd..
    //a kada koristimo intgration test onda rucno ubacujemo addresu .
    //i pozivamo fundFundMe(sa adresom)
    function run() external {
        //get most recent deployed contract
        //with ffi=true u tomly, to je comd bash pa pretrazuje local folder
        //brodcast folder
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("Withdraw FundMe balance!");
    }

    //run je za forge script scripts/Interactions.s.sol --rpc-url itd..
    //a kada koristimo intgration test onda koristimo svoj ugovor.
    //i pozivamo withdrawFundMe(sa adresom)
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        withdrawFundMe(mostRecentlyDeployed);
    }
}
