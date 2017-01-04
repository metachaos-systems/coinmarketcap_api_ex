# Unofficial Coinmarketcap.com API client

The following functions are available:

* `ticker` and `ticker("token_name")` for ticker and 24h data
* `global_data` for number of active tokens, assets, etc.
* `fetch_coin_data("token_name")` for historical data
* `fetch_known_coins_data` for all coinmarketcap tokens catalog


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add coinmarketcap_com to your list of dependencies in `mix.exs`:

        def deps do
          [{:coinmarketcap_api_ex, "~> 0.0.1"}]
        end
