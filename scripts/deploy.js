const { ethers } = require("hardhat");
const { yellow, cyan } = require("colors");

const { deployContract, verifyContract } = require("./utils");
const { utils } = require("ethers");

function fromEth(num) {
  return utils.parseEther(num.toString());
}

const maxClick = 100000;
const rewardAmount = fromEth(1000);

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("\nDeploying Contracts\n".yellow);
  const clickerToken = await deployContract(deployer, "ClickerToken", []);
  console.log("ClickerToken Deployed: ", clickerToken.address);

  const cookieClicker = await deployContract(deployer, "CookieClicker", [maxClick, clickerToken.address, rewardAmount]);

  console.log("CookieClicker deployed: ", cookieClicker.address);

  await clickerToken.transfer(cookieClicker.address, rewardAmount);
}

main();
