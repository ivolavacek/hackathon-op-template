// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {console2} from "forge-std/console2.sol";
import {Test} from "forge-std/Test.sol";
import {GIVTokens} from "../src/GIVTokens.sol";


contract GIVTokensTest is Test {
    GIVTokens givtokens = new GIVTokens();

     function test_Faucet() public {
      vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
         givtokens.claimTokens();
         uint256 Balance = givtokens.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
         assert(Balance ==  100*1e18);
      vm.stopPrank();      
    }

  function test_Transfer() public {
         vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        givtokens.claimTokens();
        givtokens.transfer(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 5*1e18);

       assert(givtokens.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) == 95*1e18);
       assert(givtokens.balanceOf(0x70997970C51812dc3A010C7d01b50e0d17dc79C8) == 5*1e18);
       vm.stopPrank();  
    }

    function test_MintNFT() public {
      vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
      givtokens.claimTokens();
      givtokens.approve(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 50*1e18);
       vm.stopPrank();  
       
      vm.startPrank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
      givtokens.transferFrom(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84, 50*1e18);
      vm.stopPrank();  
      assert(givtokens.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) == 50*1e18);
    }




   
}
