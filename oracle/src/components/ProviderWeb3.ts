import { http, createWalletClient, publicActions, Client } from "viem"
import { sepolia } from "viem/chains"
import { config } from "../../config"
import { privateKeyToAccount } from "viem/accounts"

export default class ProviderWeb3 {
  walletClient: Client

  constructor() {
    this.walletClient = createWalletClient({
      account: privateKeyToAccount(config.ethPrivateKey),
      chain: sepolia,
      transport: http(config.infuraURL),
    }).extend(publicActions)
  }
}
