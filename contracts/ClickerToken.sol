// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ClickerToken is ERC20 {
    constructor() ERC20("Clicker Token", "CLT") {
        _mint(msg.sender, 1000000 * 1e18);
    }
}
