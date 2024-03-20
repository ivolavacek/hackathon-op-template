// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

interface GIVTokensInterface {
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract Counter is ERC721, ERC721URIStorage, Ownable {
    string contractABI = '[{\"inputs\":[],\"name\":\"name\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"symbol\",\"outputs\":[{\"internalType\":\"string\",\"name\":\"\",\"type\":\"string\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"decimals\",\"outputs\":[{\"internalType\":\"uint8\",\"name\":\"\",\"type\":\"uint8\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"totalSupply\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"account\",\"type\":\"address\"}],\"name\":\"balanceOf\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"approve\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"from\",\"type\":\"address\"},{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transferFrom\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"spender\",\"type\":\"address\"}],\"name\":\"allowance\",\"outputs\":[{\"internalType\":\"uint256\",\"name\":\"\",\"type\":\"uint256\"}],\"stateMutability\":\"view\",\"type\":\"function\"},{\"inputs\":[],\"name\":\"claimTokens\",\"outputs\":[],\"stateMutability\":\"external\",\"type\":\"function\"},{\"inputs\":[{\"internalType\":\"address\",\"name\":\"to\",\"type\":\"address\"},{\"internalType\":\"uint256\",\"name\":\"value\",\"type\":\"uint256\"}],\"name\":\"transfer\",\"outputs\":[{\"internalType\":\"bool\",\"name\":\"\",\"type\":\"bool\"}],\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"stateMutability\":\"payable\",\"type\":\"fallback\"}]';
    uint256 private _nextTokenId;
    mapping(uint256 => bool) _locked;
    address public contractAdress = 0x61654CF9599DB84B65DeF545381034f2ed31893c;
    ERC20 public givTokensContract;

    constructor(address initialOwner)
      
        ERC721("GivKey", "GIV")
        Ownable(initialOwner)
    {  givTokensContract = ERC20(contractAdress);}

    

    event Locked(uint256 tokenId);


    function getERC20Balance(address account) public view returns (uint256) {
        return givTokensContract.balanceOf(account);
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        require(balanceOf(to) == 0, "ja possui algum token deste contrato");
        uint256 tokenId = _nextTokenId++;
        _locked[tokenId] = true;
        emit Locked(tokenId);
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }
    
    function ownsToken(address user) public view returns (bool) {
        return balanceOf(user) > 0;
    }

    function balanceToken(address user) public view returns (uint256) {
        return balanceOf(user);
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721)
        returns (address)
    {
        address from = ownerOf(tokenId);
    if (from != address(0)) {
        revert("Transfer not allowed");  // Prevent all transfers, making the token soulbound and non-burnable
    }
        return super._update(to, tokenId, auth);
    }

   
    // Required overrides  

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}


//     function safeTransferFrom(
//         address from,
//         address to,
//         uint256 tokenId
//     ) public virtual override pure {
//         revert("Transfer not allowed");
//     }

//     function transferFrom(
//         address from,
//         address to,
//         uint256 tokenId
//     ) public virtual override pure {
//         revert("Transfer not allowed");
//     }
// }

// Remova as funções approve e setApprovalForAll
// function approve(address, uint256) public virtual override pure {
//     revert("Approval not allowed");
// }

// function setApprovalForAll(address, bool) public virtual override pure {
//     revert("Approval not allowed");
// }