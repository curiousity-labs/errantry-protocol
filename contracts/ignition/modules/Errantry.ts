import { buildModule } from "@nomicfoundation/hardhat-ignition/modules"

const ErrantryModule = buildModule("ErrantryModule", (m) => {
  const errantry = m.contract("Errantry", [])
  return { errantry }
})

export default ErrantryModule
