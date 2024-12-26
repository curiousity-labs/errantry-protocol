import { useWalletClient } from "wagmi"
import "./css/App.css"
import ConnectWallet from "./ConnectWallet"

function App() {
  const { data: client, isLoading } = useWalletClient()

  return (
    <div className="app">
      <ConnectWallet
        connectedAddress={client?.account.address}
        isWalletAccountConnected={!!client}
        isWalletAccountLoading={isLoading}
      />
      <div>No Show</div>
    </div>
  )
}

export default App
