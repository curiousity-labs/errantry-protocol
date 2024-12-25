import ProviderReOwn from "./ProviderReOwn"

export default function Providers({ children }: { children: React.ReactNode }) {
  return (
    <>
      <ProviderReOwn>{children}</ProviderReOwn>
    </>
  )
}
