import * as dotenv from "dotenv"
import { Address, getAddress } from "viem"
dotenv.config()

interface Config {
  port: string
  isDev: boolean
  infuraURL: string
  ethPrivateKey: Address
  redisURL: string
}

if (!process.env.PORT) {
  throw new Error("PORT is not defined")
}
if (!process.env.ETH_PRIVATE_KEY) {
  throw new Error("ETH_DEPLOYER_PRIVATE_KEY is not defined")
}
if (!process.env.INFURA_API_KEY) {
  throw new Error("INFURA_API_KEY is not defined")
}
export const config: Config = {
  port: process.env.PORT,
  isDev: process.env.NODE_ENV === "development",
  ethPrivateKey: getAddress(process.env.ETH_PRIVATE_KEY),
  infuraURL: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
  redisURL: process.env.REDIS_URL || "redis://localhost:6379",
}
