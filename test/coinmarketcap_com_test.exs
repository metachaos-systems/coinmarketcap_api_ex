defmodule CoinmarketcapApiTest do
  use ExUnit.Case
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
end
