// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CookieClicker is Ownable, ReentrancyGuard {
    // 7 Items to support
    uint256[7] public cursorPrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    uint256[7] public grandmaPrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    uint256[7] public farmPrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    uint256[7] public minePrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    uint256[7] public factoryPrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    uint256[7] public bankPrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    uint256[7] public templePrices = [1, 10, 100, 200, 300, 500, 1000, 1, 10, 100, 200, 300, 500, 1000, 10000];
    // Item possession
    mapping(address => mapping(uint256 => uint256)) public items;

    uint256 private decimal = 1e18;

    uint256 public maxClicks;

    // CLicker_token address
    address public clickerToken;

    // Reward Amount
    uint256 public rewardAmount;

    constructor(uint256 _maxClicks, address _clickerToken, uint256 _rewardAmount) {
        maxClicks = _maxClicks;
        clickerToken = _clickerToken;
        rewardAmount = _rewardAmount;
    }

    function buyUpgrades(uint256 itemID, string upgradename) public {

        if (upgradename == "cursor"){
            uint256 price = cursorPrices[itemID];
        }
        else if (upgradename == "grandma"){
            uint256 price = grandmaPrices[itemID];
        }
        else if (upgradename == "farm"){
            uint256 price = farmPrices[itemID];
        }
        else if (upgradename == "mine"){
            uint256 price = minePrices[itemID];
        }
        else if (upgradename == "factory"){
            uint256 price = factoryPrices[itemID];
        }
        else if (upgradename == "bank"){
            uint256 price = bankPrices[itemID];
        }
        else if (upgradename == "temple"){
            uint256 price = templePrices[itemID];
        }
        else{
            return "Type Error";
        };


        require(IERC20(clickerToken).allowance(msg.sender, address(this)) >= price * decimal, "NOT_ENOUGH_ALLOWANCE");

        IERC20(clickerToken).transferFrom(msg.sender, address(this), price * decimal);

        // increase item possession
        items[msg.sender][itemID] += 1;
    }

    // function winReward(address winner) public onlyOwner {
    //     require(winner != address(0), "ZERO_ADDRESS");

    //     require(IERC20(clickerToken).balanceOf(address(this)) >= rewardAmount, "INCUFFICIENT_TOKEN_AMT");

    //     IERC20(clickerToken).transfer(winner, rewardAmount);
    // }
    function resetHighscore(uint256 maxClicks) public{

    }
}
