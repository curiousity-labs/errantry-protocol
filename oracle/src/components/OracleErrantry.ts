import { errantryAbi } from "src/abis/errantryAbi"
import ProviderWeb3 from "./ProviderWeb3"
import { Address, getAddress, getContract, zeroAddress } from "viem"
import { errandManagerAbi } from "src/abis/errandManagerAbi"
import { errantryClientSmartAccountAbi } from "src/abis/errantryClientSmartAccountAbi"

export default class OracleErrantry {
  errantryProtocolAddress = getAddress("0x78b68023fD65d3ef06878675f80Bf22378a93746") // sepolia
  providerWeb3: ProviderWeb3

  constructor() {
    this.providerWeb3 = new ProviderWeb3()
    this.subscribeClientRegistration()
  }

  getErrantryContract() {
    return getContract({
      abi: errantryAbi,
      address: this.errantryProtocolAddress,
      client: this.providerWeb3.writeClient,
    })
  }

  getErrandManagerContract(errandManagerAddress: Address) {
    return getContract({
      abi: errandManagerAbi,
      address: errandManagerAddress,
      client: this.providerWeb3.writeClient,
    })
  }

  getErrantrySmartClientAccountContract(clientSmartAccountAddress: Address) {
    return getContract({
      abi: errantryClientSmartAccountAbi,
      address: clientSmartAccountAddress,
      client: this.providerWeb3.readClient,
    })
  }

  // read from the blockchain
  async subscribeClientRegistration() {
    const contract = this.getErrantryContract()
    contract.watchEvent.ClientRegistered({
      onLogs: async (logs) => {
        const clientSmartAccountAddress = zeroAddress
        const errandManagerContractAddress = zeroAddress

        // add action to storage processing queue
        console.log("🚀 ~ logs:", logs)
      },
      onError: (err) => {
        // @todo store errors for later debugging
        console.error("Error: ", err)
      },
    })
  }

  async subscribeErrandRunnerUpdated(errandManager: Address, errandId: bigint) {
    this.getErrandManagerContract(errandManager).watchEvent.ErrandRunnerUpdated(
      {
        errandId,
      },
      {
        onLogs: async (logs) => {
          // add action to storage processing queue
          console.log("🚀 ~ logs:", logs)
        },
        onError: (err) => {
          // @todo store errors for later debugging
          console.error("Error: ", err)
        },
      }
    )
  }

  async subscribeErrandRunnerPaid(errandManager: Address, errandId: bigint) {
    this.getErrandManagerContract(errandManager).watchEvent.ErrandPaid(
      {
        errandId,
      },
      {
        onLogs: async (logs) => {
          // add action to storage processing queue
          console.log("🚀 ~ logs:", logs)
        },
        onError: (err) => {
          // @todo store errors for later debugging
          console.error("Error: ", err)
        },
      }
    )
  }

  // write to the blockchain
  async postNewErrand() {}
  async updateErrandStatus() {}
}
