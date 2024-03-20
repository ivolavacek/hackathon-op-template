// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {GIVTokens} from "../src/GIVTokens.sol";

contract Testnet is Script {
    GIVTokens givTokens;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        givTokens = new GIVTokens();
        console2.log("GIV address: ", address(givTokens));

     

        vm.stopBroadcast();
    }
}
