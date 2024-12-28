import { buildModule } from "@nomicfoundation/hardhat-ignition/modules"
import { zeroAddress } from "viem"

const ErrantryModule = buildModule("ErrantryModule", (m) => {
  // args = [address entry point, address oracle address]
  const errantry = m.contract("Errantry", [zeroAddress, zeroAddress])
  return { errantry }
})

export default ErrantryModule
