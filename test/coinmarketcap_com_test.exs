defmodule CoinmarketcapApiTest do
  use ExUnit.Case, async: true
  doctest CoinmarketcapApi
  import CoinmarketcapApi

  test "fetch coin data for bitcoin" do
    {:ok, data} = fetch_coin_data("bitcoin")
    assert %{"market_cap_by_available_supply" => [[_, _] | _ ]}  = data
  end

  test "fetch known coins data" do
    {:ok, data} = fetch_known_coins_data()
    assert [%{"name" => _, "slug" => _} | _ ] = data
  end

  test "all tickers" do
    {:ok, data} = fetch_ticker()
    assert [%{"id" => _, "24h_volume_usd" => _} | _ ] = data
  end

  test "tickers with limit" do
    {:ok, data} = fetch_ticker(%{limit: 3})
    assert length(data) == 3
  end

  test "tickers with start and limit" do
    {:ok, data} = fetch_ticker(%{start: 5, limit: 5})
    assert length(data) == 5

    [ head | _ ] = data
    assert head["rank"] == "6"
  end

  test "all tickers with convert" do
    {:ok, data} = fetch_ticker_convert("BRL")
    [first | _ ] = data
    assert Map.has_key?(first, "price_brl")
  end

  test "bitcoin tickers with convert" do
    {:ok, data} = fetch_ticker_convert("bitcoin", "brl")
    [first | _ ] = data
    assert Map.has_key?(first, "price_brl")
    assert %{"id" => _, "24h_volume_usd" => _, "symbol" => "BTC"} = first
  end

  test "bitcoin tickers" do
    {:ok, data} = fetch_ticker("bitcoin")
    assert [%{"id" => _, "24h_volume_usd" => _, "symbol" => "BTC"} | _ ] = data
  end

  test "global data" do
    {:ok, data} = fetch_global_data()
    assert %{"active_assets" => _} = data
  end
end
