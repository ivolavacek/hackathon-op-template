// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {GIVTokens} from "../src/GIVTokens.sol";

contract Testnet is Script {
    GIVTokens givTokens;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        givTokens = new GIVTokens();
        console2.log("GIV address: ", address(givTokens));

        givTokens.claimTokens();
        console2.log(givTokens.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266));

        givTokens.transfer(0x5FbDB2315678afecb367f032d93F642f64180aa3, 5*1e18);
         console2.log(givTokens.balanceOf(0x5FbDB2315678afecb367f032d93F642f64180aa3));

        vm.stopBroadcast();
    }
}
