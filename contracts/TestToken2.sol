// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@4.9.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.9.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";

// ERC5169 interface declaration
interface IERC5169 {
    event ScriptUpdate(string[]);

    function scriptURI() external view returns (string[] memory);
    function setScriptURI(string[] memory) external;
}

contract TestToken is ERC721, ERC721Enumerable, Ownable, IERC5169 {
    uint private _tokenIdCounter;
    string private constant baseTokenURI = "ipfs://QmQgPRvpucr7FgCKXHfAUJaV1a3EoKX3guDBiDt1zozFrv";

    constructor() ERC721("TestToken", "TST") {
        _tokenIdCounter = 1;
        mint();
    }

    function mint() public onlyOwner {
        uint tokenId = _tokenIdCounter;
        _safeMint(owner(), tokenId);
        _tokenIdCounter++;
    }

    function burn(uint256 tokenId) public {
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of this token");
        _burn(tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize) internal override(ERC721, ERC721Enumerable) {
        // No additional logic required here
    }

    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        return baseTokenURI;
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId) || interfaceId == type(IERC5169).interfaceId;
    }

    string[] private _scriptURI;

    function scriptURI() external view override returns (string[] memory) {
        return _scriptURI;
    }

    function setScriptURI(string[] memory newScriptURI) external override onlyOwner {
        _scriptURI = newScriptURI;
        emit ScriptUpdate(newScriptURI);
    }
}