// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/NFT.sol";

contract CounterScript is Script {
    address initialOwner = msg.sender; // Ou defina o endereço do proprietário desejado
    string tokenURI = "ipfs://your_token_uri_here"; // Substitua pela URI do seu token
    address receiver = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function run() external {
        vm.startBroadcast(initialOwner);

        Counter counter = new Counter(initialOwner);
        console.log("Contract deployed to:", address(counter));

        counter.safeMint(receiver, tokenURI);
        console.log("GIV_Access_SBT minted to:", receiver);

        bool isOwned = counter.ownsToken(receiver);
        console.log("Owns Token:", isOwned);

        uint256 balance = counter.balanceToken(receiver);
        console.log("balance", balance);

        vm.stopBroadcast();
    }
}

