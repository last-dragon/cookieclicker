const { ethers, network, waffle } = require("hardhat");
const { expect } = require("chai");
const colors = require("colors");
const { utils } = require("ethers");

function toEth(num) {
  return utils.formatEther(num);
}

function fromEth(num) {
  return utils.parseEther(num.toString());
}

const maxClick = 100000;
const rewardAmount = fromEth(1000);

let cookieClicker, clickerToken;

describe("Cookie Clicker test", async () => {
  before(async () => {
    [deployer, alice, bob, carol, david, evan, fiona, treasury] = await ethers.getSigners();

    // Deploy Cookie Contract
    console.log("Deploying Cookie token".green);
    const ClickerToken = await ethers.getContractFactory("ClickerToken");
    clickerToken = await ClickerToken.deploy();
    console.log(`ClickerToken deployed at: ${clickerToken.address}\n`);

    // Deploy CookieClicker
    console.log("Deploying CookieClicker".green);
    const CookieClicker = await ethers.getContractFactory("CookieClicker");
    cookieClicker = await CookieClicker.deploy(maxClick, clickerToken.address, rewardAmount);
    console.log(`CookieClicker deployed at: ${cookieClicker.address}\n`);
  });

  it("Transfer Clicker token to clicker contract", async () => {
    await clickerToken.transfer(cookieClicker.address, rewardAmount);
  });

  it("Buy Item and check possession", async () => {
    // Approve clicker token to buy item
    await clickerToken.approve(cookieClicker.address, fromEth(10000000));

    // Buy item
    await cookieClicker.buyItem(0);

    // Check item possession
    expect(await cookieClicker.items(deployer.address, 0)).to.equal(1);
  });

  it("Buy Item and check balance change", async () => {
    const beforeAmt = await clickerToken.balanceOf(cookieClicker.address);
    await cookieClicker.buyItem(1);

    expect(await cookieClicker.items(deployer.address, 1)).to.equal(1);
    const afterAmt = await clickerToken.balanceOf(cookieClicker.address);

    // Check clicker amount
    expect(afterAmt.sub(beforeAmt)).to.equal(fromEth(10));
  });
});
