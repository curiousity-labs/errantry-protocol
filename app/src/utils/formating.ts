export function formatAddress(address: string | `0x${string}`) {
  return `${address.substring(0, 6)}...${address.slice(-4)}`
}
