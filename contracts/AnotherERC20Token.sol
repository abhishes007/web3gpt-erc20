// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// EIP 5169 interface declaration
interface IERC5169 {
    event ScriptUpdate(string[]);

    function scriptURI() external view returns (string[] memory);
    function setScriptURI(string[] memory) external;
}

contract AnotherERC20Token is ERC20, Ownable, IERC5169 {
    string[] private _scriptURI;

    constructor() ERC20("AnotherERC20Token", "TT20") {
        uint256 initialSupply = 1000000 * 10 ** decimals();
        _mint(msg.sender, initialSupply);
    }

    function scriptURI() external view override returns (string[] memory) {
        return _scriptURI;
    }

    function setScriptURI(string[] memory newScriptURI) external override onlyOwner {
        _scriptURI = newScriptURI;
        emit ScriptUpdate(newScriptURI);
    }
}