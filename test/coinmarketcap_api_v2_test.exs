defmodule CoinmarketcapApi.V2ClientTest do
  use ExUnit.Case, async: true
  doctest CoinmarketcapApi
  import CoinmarketcapApi.V2Client

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

  test "bitcoin tickers" do
    {:ok, data} = fetch_ticker("bitcoin")
    assert [%{"id" => _, "24h_volume_usd" => _, "symbol" => "BTC"} | _ ] = data
  end

  test "global data" do
    {:ok, data} = fetch_global_data()
    assert %{"active_assets" => _} = data
  end
end
