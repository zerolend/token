// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// This token represents the early bird version of the $ZERO token. Users who claim this token will be able
// to redeem the original $ZERO on launch.

contract EarlyZerolend is ERC20, ERC20Burnable, Ownable {
    mapping(address => bool) fromWhitelist;
    bool enableWhitelist;

    constructor() ERC20("Earlybid ZERO", "earlyZERO") {
        fromWhitelist[msg.sender] = true;
        fromWhitelist[address(this)] = true;
        fromWhitelist[address(0)] = true;

        enableWhitelist = true;

        _mint(msg.sender, 100000000000 * 1e18); // 100 bil tokens
    }

    function addToWhitelist(address who, bool what) external onlyOwner {
        fromWhitelist[who] = what;
    }

    function toggleWhitelist(bool what) external onlyOwner {
        enableWhitelist = what;
    }

    function _afterTokenTransfer(
        address from,
        address,
        uint256
    ) internal virtual override {
        if (enableWhitelist) {
            require(fromWhitelist[from], "from address not in whitelist");
        }
    }
}
