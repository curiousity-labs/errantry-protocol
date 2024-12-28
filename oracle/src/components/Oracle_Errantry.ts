import ProviderWeb3 from "./Provider_Web3"

export default class ErrantryOracle {
  errantryProtocolAddress = "0x0"
  providerWeb3: ProviderWeb3

  constructor() {
    this.providerWeb3 = new ProviderWeb3()
  }

  // read from the blockchain
  async subscribeClientRegistration() {}
  async subscribeClientErrands() {}

  // write to the blockchain
  async postNewErrand() {}
  async updateErrandStatus() {}
}
