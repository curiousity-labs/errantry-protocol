import { formatAddress } from "../utils/formating"
import "./css/Loader.css"

export default function ConnectWallet({
  connectedAddress,
  isWalletAccountConnected,
  isWalletAccountLoading,
}: {
  connectedAddress: `0x${string}` | undefined
  isWalletAccountConnected: boolean
  isWalletAccountLoading: boolean
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
      <div className="card popup">
        <div>You need to connect</div>
      </div>
    )
  }
  if (isWalletAccountConnected && connectedAddress) {
    return (
      <div className="card popup-top-right">
        <div>
          <div>{formatAddress(connectedAddress)}</div>
        </div>
      </div>
    )
  }
}
