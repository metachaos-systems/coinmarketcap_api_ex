# Unofficial Coinmarketcap.com v2 API client

This module implements v2 Coinmarketcap API with minimal changes to API structure. Use 1.x.x version for previous CMC API.

All CMC API endpoints are called using fetch_#{endpoint} functions and return success tuple with `%CoinmarketcapApi.Response{}` containing :data and :metadata.

## Installation

If [available in Hex](https://hex.pm/coinmarketcap_api_ex), the package can be installed as:

  1. Add coinmarketcap_api_ex to your list of dependencies in `mix.exs`:

        def deps do
          [{:coinmarketcap_api_ex, "~> 2.0.0"}]
        end

# Configuration

Configuration is not required.

# Documentation

More docs and example return values can be found at [hexdocs](https://hexdocs.pm/coinmarketcap_api/2.0.0/CoinmarketcapApi.html).

# Tickers

All ticker related functions return either a Ticker struct or a list of Ticker structs.

Ticker structs have the following shape:


```
%CoinmarketcapApi.Ticker{
  circulating_supply: 17035225,
  id: 1,
  last_updated: ~N[2018-05-15 17:44:33],
  max_supply: 21000000,
  name: "Bitcoin",
  quotes: %{
    "USD" => %CoinmarketcapApi.Quote{
      market_cap: 145773657018.0,
      percent_change_1h: -0.26,
      percent_change_24h: -2.54,
      percent_change_7d: -7.03,
      price: 8557.19,
      volume_24h: 6.69447e9
    }
  },
  rank: 1,
  symbol: "BTC",
  total_supply: 17035225,
  website_slug: "bitcoin"
}
```

Examples:

* CoinmarketcapApi.fetch_ticker()
* CoinmarketcapApi.fetch_ticker([start: 100, limit: 50])
* CoinmarketcapApi.fetch_ticker([start: 100, limit: 50, convert: "EUR"])
* CoinmarketcapApi.fetch_ticker(1)
* CoinmarketcapApi.fetch_ticker(1, convert: "EUR")

Ticker values are parsed to the most fitting Elixir datatypes:

* id -> Integer
* last_updated -> NaiveDateTime
* {total,circulating,max}_supply -> Integer

# Listings

`fetch_listings` function returns all active cryptocurrency listings. You can then use `fetch_ticker(id)` to query more information for a specific cryptocurrency.

# Global Data

`fetch_global_data` returns the global data found at the top of coinmarketcap.
