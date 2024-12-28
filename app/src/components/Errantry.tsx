type ErrantryProps = {
  connectedAddress: `0x${string}` | undefined
}

export default function Errantry({ connectedAddress }: ErrantryProps) {
  if (!connectedAddress) {
    return null
  }
  return (
    <div className="card popup flex-align-center">
      <div className="loader" />
    </div>
  )
}
