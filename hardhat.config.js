require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-ethers');
require('dotenv').config();

const SEPOLIA_URL = `https://eth-sepolia.g.alchemy.com/v2/pg102ZDg6_eE7Es497bT-QssRC1Mk5VB`;
const WALLET_PRIVATE_KEY = process.env.WALLET_PRIVATE_KEY; // Add your wallet private key in a .env file


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    sepolia: {
      url: SEPOLIA_URL,
      accounts: [WALLET_PRIVATE_KEY]
    }
  }
};
