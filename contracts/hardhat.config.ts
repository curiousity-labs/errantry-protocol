import type { HardhatUserConfig } from "hardhat/config"
import * as dotenv from "dotenv"
import "@nomicfoundation/hardhat-toolbox-viem"
import "@nomicfoundation/hardhat-verify"

dotenv.config()

// first address from hardhat node
const dummyPrivateKey = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  paths: {
    sources: "./src",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  networks: {
    sepolia: {
      chainId: 11155111,
      url: process.env.SEPOLIA_PROVIDER || "https://ethereum-sepolia-rpc.publicnode.com",
      accounts: process.env.SEPOLIA_DEPLOYER_PRIVATE_KEY
        ? [process.env.SEPOLIA_DEPLOYER_PRIVATE_KEY]
        : [dummyPrivateKey],
    },

    base: {
      chainId: 8453,
      url: process.env.BASE_PROVIDER || "https://base-rpc.publicnode.com",
      accounts: process.env.BASE_DEPLOYER_PRIVATE_KEY
        ? [process.env.BASE_DEPLOYER_PRIVATE_KEY]
        : [dummyPrivateKey],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY || "",
  },
}

export default config
