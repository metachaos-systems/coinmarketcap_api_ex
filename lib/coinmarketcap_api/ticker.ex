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
  use ExConstructor

  def parse(ticker) do
    ticker
    |> Map.update!(:circulating_supply, &parse_supply/1)
    |> Map.update!(:total_supply, &parse_supply/1)
    |> Map.update!(:max_supply, &parse_supply/1)
    |> Map.update!(:last_updated, &parse_times/1)
  end

  def parse_supply(nil), do: nil
  def parse_supply(float), do: round(float)

  def parse_times(unix_time) do
    DateTime.from_unix!(unix_time) |> DateTime.to_naive()
  end

end
