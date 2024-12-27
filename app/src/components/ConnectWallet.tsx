import { useState } from "react"
import { formatAddress } from "../utils/formating"
import "../assets/css/Loader.css"
import "../assets/css/Animation.css"
import CopyIcon from "../assets/images/copy.svg?react"
import DisconnectIcon from "../assets/images/disconnect.svg?react"
// @todo move to a network config file
import SepoliaNetworkIcon from "../assets/images/coin-icon-sep.svg?react"

function WalletDisplay({
  connectedAddress,
  disconnectWallet,
}: {
  connectedAddress: `0x${string}`
  disconnectWallet: () => void
}) {
  const [isHovered, setIsHovered] = useState(false)
  const displayedAddress = isHovered ? connectedAddress : formatAddress(connectedAddress)
  return (
    <div
      className="card padding-animated popup-top-right flex-align-center"
      style={{ minWidth: "fit-content" }}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
    >
      <div>
        <div className="gap-2 flex-align-center">
          <div className="address">{displayedAddress}</div>
          <SepoliaNetworkIcon className="network-icon" />
        </div>
        {isHovered && (
          <div className="flex gap-2 space-between mt-4">
            <button
              className="button-secondary button-icon"
              onClick={() => navigator.clipboard.writeText(connectedAddress)}
            >
              <CopyIcon />
            </button>
            <button className="button-danger button-icon" onClick={disconnectWallet}>
              <DisconnectIcon />
            </button>
          </div>
        )}
      </div>
    </div>
  )
}

export default function ConnectWallet({
  connectedAddress,
  isWalletAccountConnected,
  isWalletAccountLoading,
  connectWallet,
  disconnectWallet,
}: {
  connectedAddress: `0x${string}` | undefined
  isWalletAccountConnected: boolean
  isWalletAccountLoading: boolean
  connectWallet: () => void
  disconnectWallet: () => void
}) {
  if (isWalletAccountLoading) {
    return (
      <div className="card popup">
        <div className="loader" />
      </div>
    )
  }
  if (!isWalletAccountConnected) {
    return (
      <div className="card popup flex-align-center">
        <button className="button-primary" onClick={connectWallet}>
          Connect your wallet
        </button>
      </div>
    )
  }
  if (isWalletAccountConnected && connectedAddress) {
    return <WalletDisplay connectedAddress={connectedAddress} disconnectWallet={disconnectWallet} />
  }
}
