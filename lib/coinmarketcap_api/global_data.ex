defmodule CoinmarketcapApi.GlobalData do
  defstruct [
    :active_cryptocurrencies,
    :active_markets,
    :bitcoin_percentage_of_market_cap,
    :last_updated,
    :quotes
  ]

  use ExConstructor
end
