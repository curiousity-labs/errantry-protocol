import { http, PublicClient, WalletClient, createPublicClient, createWalletClient } from "viem"
import { sepolia } from "viem/chains"

export default class ProviderWeb3 {
  readClient: PublicClient
  writeClient: WalletClient

  constructor() {
    this.readClient = createPublicClient({
      chain: sepolia,
      transport: http("https://mainnet.infura.io/v3/your-infura-key"),
    })
    this.writeClient = createWalletClient({
      chain: sepolia,
      transport: http("https://mainnet.infura.io/v3/your-infura-key"),
    })
  }
}
