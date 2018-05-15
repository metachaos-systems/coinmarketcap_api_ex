defmodule CoinmarketcapApi.V2ClientTest do
  use ExUnit.Case, async: true
  doctest CoinmarketcapApi
  import CoinmarketcapApi.V2Client

  test "tickers with limit" do
    {:ok, %{data: data}} = fetch_ticker(%{limit: 3})
    assert length(Map.to_list(data)) == 3
  end

  test "tickers with start and limit" do
    {:ok, %{data: data}} = fetch_ticker(%{start: 5, limit: 5})
    assert length(Map.to_list(data)) == 5
  end

end
