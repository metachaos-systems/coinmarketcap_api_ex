defmodule CoinmarketcapApi.V2ClientTest do
  use ExUnit.Case, async: true
  doctest CoinmarketcapApi
  import CoinmarketcapApi.V2Client

  test "all tickers" do
    {:ok, %{data: data}} = fetch_ticker()
    assert %{id:  _, quotes:  _} = data["1"]
  end

  test "tickers with limit" do
    {:ok, %{data: data}} = fetch_ticker([limit: 3])
    assert length(Map.to_list(data)) == 3
  end

  test "tickers with start and limit" do
    {:ok, %{data: data}} = fetch_ticker([start: 5, limit: 5])
    {id, ticker_data} = hd(Map.to_list(data))
    assert %{id: _, quotes:  _, symbol:  _} = ticker_data
  end

  test "bitcoin tickers" do
    {:ok, %{data: data}} = fetch_ticker(1)
    assert is_integer(data.circulating_supply)
    assert NaiveDateTime.to_string(data.last_updated)
    assert %{id: _, quotes:  _, symbol:  "BTC"} = data
  end

  test "global data" do
    {:ok, %{data: data}} = fetch_global_data()
    assert %{active_cryptocurrencies:  _} = data
  end
end
