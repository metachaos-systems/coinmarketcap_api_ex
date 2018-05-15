defmodule CoinmarketcapApi.Ticker do
  defstruct [
    :circulating_supply,
    :id,
    :last_updated,
    :max_supply,
    :name,
    :quotes,
    :rank,
    :symbol,
    :total_supply,
    :website_slug
  ]
end
