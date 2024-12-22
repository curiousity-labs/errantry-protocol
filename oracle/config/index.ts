import { Config } from "../types/app"
import dotenv from "dotenv"
dotenv.config()

const config: Config = {
  port: process.env.PORT,
  isDev: process.env.NODE_ENV === "development",
  ethPrivateKey: process.env.ETH_PRIVATE_KEY,
  etherscanUrl: "https://api.goerli.etherscan.io/api",
  infuraURL: `https://goerli.infura.io/v3/${process.env.INFURA_API_KEY}`,
}

export default config
