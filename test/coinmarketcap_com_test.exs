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
    {:ok, data} = ticker()
    assert [%{"id" => _, "24h_volume_usd" => _} | _ ] = data
  end

  test "bitcoin tickers" do
    {:ok, data} = ticker("bitcoin")
    assert [%{"id" => _, "24h_volume_usd" => _, "symbol" => "BTC"} | _ ] = data
  end

  test "global data" do
    {:ok, data} = global_data()
    assert %{"active_assets" => _} = data
  end
end
