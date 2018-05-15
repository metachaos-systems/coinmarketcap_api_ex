defmodule CoinmarketcapApi.GlobalData do
  defstruct [
    :active_cryptocurrencies,
    :active_markets,
    :bitcoin_percentage_of_market_cap,
    :last_updated,
    :quotes
  ]

  use ExConstructor

  def parse(data) do
    data
    |> Map.update!(:last_updated, &parse_times/1)
  end

  def parse_times(unix_time) do
    DateTime.from_unix!(unix_time) |> DateTime.to_naive()
  end
end
