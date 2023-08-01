const { verifyContract } = require("./utils");

const { utils } = require("ethers");
function fromEth(num) {
  return utils.parseEther(num.toString());
}

const maxClick = 100000;
const rewardAmount = fromEth(1000);

const main = async () => {
  const clickerToken = "0x4bFF3F220E66C21A88a8D78c66C9349d7C22dE28";

  const cookieClicker = "0x4dbb3DA54CDa3BDa4386731d6162Ed8Da834D6ce";

  await verifyContract(clickerToken, []);
  await verifyContract(cookieClicker, [maxClick, clickerToken, rewardAmount]);
};

main();
