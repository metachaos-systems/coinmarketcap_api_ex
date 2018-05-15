defmodule CoinmarketcapApiTest do
  use ExUnit.Case, async: true
  doctest CoinmarketcapApi
  alias CoinmarketcapApi.Quote
  import CoinmarketcapApi

  test "all tickers" do
    {:ok, %{data: data}} = fetch_ticker()
    assert %{id:  _, quotes:  _} = data[1]
  end

  test "tickers with limit" do
    {:ok, %{data: data}} = fetch_ticker([limit: 3])
    assert length(Map.to_list(data)) == 3
  end

  test "tickers with start and limit" do
    {:ok, %{data: data}} = fetch_ticker([start: 1, limit: 5])
    {id, ticker_data} = hd(Map.to_list(data))
    assert %{id: ^id, quotes:  _, symbol:  _} = ticker_data
  end

  test "bitcoin tickers" do
    {:ok, %{data: data}} = fetch_ticker(1)
    assert is_integer(data.circulating_supply) || is_nil(data.circulating_supply)
    assert is_integer(data.total_supply) || is_nil(data.total_supply)
    assert is_integer(data.max_supply) || is_nil(data.max_supply)
    assert NaiveDateTime.to_string(data.last_updated)
    assert %{id: _, quotes:  _, symbol:  "BTC"} = data
  end

  test "global data" do
    {:ok, %{data: data}} = fetch_global_data()
    assert %{active_cryptocurrencies:  _} = data
  end

  test "ticker quotes are converted to structs" do
    {:ok, %{data: data}} = fetch_ticker(1)
    quote_incoming = data.quotes["USD"]
    assert %{price: _} = quote_incoming
    assert %Quote{} = quote_incoming
  end
end
