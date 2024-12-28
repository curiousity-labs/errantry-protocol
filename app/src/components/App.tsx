import { useWalletClient } from "wagmi"
import "./App.css"
import ConnectWallet from "./ConnectWallet"
import { useAppKit, useDisconnect } from "@reown/appkit/react"
import Errantry from "./Errantry"

function App() {
  const { data: client, isLoading } = useWalletClient()
  const { open } = useAppKit()
  const { disconnect } = useDisconnect()
  return (
    <div className="app">
      <ConnectWallet
        connectedAddress={client?.account.address}
        isWalletAccountConnected={!!client}
        isWalletAccountLoading={isLoading}
        connectWallet={open}
        disconnectWallet={disconnect}
      />
      <Errantry connectedAddress={client?.account.address} />
    </div>
  )
}

export default App
