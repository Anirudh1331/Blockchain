// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.0/utils/Counters.sol";

contract MintingTrial is ERC721, Ownable {
    using Counters for Counters.Counter;

    // Mapping from token ID to warranty start date
    mapping(uint256 => uint256) private _startWarranty;

    // Mapping from token ID to warranty period
    mapping(uint256 => uint256) private _warrantyPeriod;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MintingTrial", "MTK") {}


    function getTime(uint256 startwarr, uint256 warrPeriod) private view returns(uint){
        return startwarr+warrPeriod;
    }

    function transfer(address from, address to, uint256 tid) public{
        uint256 end=getTime(_startWarranty[tid],_warrantyPeriod[tid]);
        require(block.timestamp < end,"Out of Bounds");
        _transfer(from,to,tid);
        // task
    }

    function safeMint(address to, uint256 tokenId, uint256 warrantyDuration) public onlyOwner {
        // uint256 tokenId = _tokenIdCounter.current();
        // _tokenIdCounter.increment();
        _startWarranty[tokenId]=block.timestamp;
        _warrantyPeriod[tokenId]=warrantyDuration;
        _safeMint(to, tokenId);
    }
}
