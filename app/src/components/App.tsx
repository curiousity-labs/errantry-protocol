import { useWalletClient } from "wagmi"
import "./App.css"
import ConnectWallet from "./ConnectWallet"
import { useAppKit, useDisconnect } from "@reown/appkit/react"

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
      <div>No Show</div>
    </div>
  )
}

export default App
