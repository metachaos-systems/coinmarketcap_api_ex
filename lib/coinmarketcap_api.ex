defmodule CoinmarketcapApi do
  alias CoinmarketcapApi.Ticker
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.coinmarketcap.com/v2")
  plug(CoinmarketcapApi.ResponseMiddleware)
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.FollowRedirects)

  @doc """
  Returns cryptocurrency ticker data ordered by marketcap rank. The maximum number of results per call is 100. Pagination is possible by using the start and limit parameters.

  Example response:

  ```
  {
    "data": {
        "1": {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "website_slug": "bitcoin",
            "rank": 1,
            "circulating_supply": 17008162.0,
            "total_supply": 17008162.0,
            "max_supply": 21000000.0,
            "quotes": {
                "USD": {
                    "price": 9024.09,
                    "volume_24h": 8765400000.0,
                    "market_cap": 153483184623.0,
                    "percent_change_1h": -2.31,
                    "percent_change_24h": -4.18,
                    "percent_change_7d": -0.47
                }
            },
            "last_updated": 1525137271
        },
        "1027": {
            "id": 1027,
            "name": "Ethereum",
            "symbol": "ETH",
            "website_slug": "ethereum",
            "rank": 2,
            "circulating_supply": 99151888.0,
            "total_supply": 99151888.0,
            "max_supply": null,
            "quotes": {
                "USD": {
                    "price": 642.399,
                    "volume_24h": 2871290000.0,
                    "market_cap": 63695073558.0,
                    "percent_change_1h": -3.75,
                    "percent_change_24h": -7.01,
                    "percent_change_7d": -2.32
                }
            },
            "last_updated": 1525137260
        }
        ...
    },
    "metadata": {
        "timestamp": 1525137187,
        "num_cryptocurrencies": 1602,
        "error": null
    }
  ]
  ```
  """
  def fetch_ticker() do
    get("/ticker/")
  end

  def fetch_ticker(query) when is_list(query) do
    get("/ticker/", query: query)
  end

  @deprecated "Use fetch_ticker with query option passed as keyword list"
  def fetch_ticker(opts) when is_map(opts) do
    query =
      for {k, v} <- Map.to_list(opts) do
        {k, v}
      end

    get("/ticker/", query: query)
  end

  @doc """
  Returns ticker data for a specific cryptocurrency. Use the "id" field from the Listings endpoint in the URL.
  Example response:

  ```
  {
    "data": {
        "id": 1,
        "name": "Bitcoin",
        "symbol": "BTC",
        "website_slug": "bitcoin",
        "rank": 1,
        "circulating_supply": 17008162.0,
        "total_supply": 17008162.0,
        "max_supply": 21000000.0,
        "quotes": {
            "USD": {
                "price": 9024.09,
                "volume_24h": 8765400000.0,
                "market_cap": 153483184623.0,
                "percent_change_1h": -2.31,
                "percent_change_24h": -4.18,
                "percent_change_7d": -0.47
            }
        },
        "last_updated": 1525137271
    },
    "metadata": {
        "timestamp": 1525237332,
        "error": null
    }

  }

  ```
  """
  def fetch_ticker(id, query \\ []) do
    get("/ticker/#{id}/", query: query)
  end

  @doc """
  Returns all active cryptocurrency listings. Use fetch_ticker to query more information for a specific cryptocurrency.

  Example response:
  ```
  {
    "data": [
        {
            "id": 1,
            "name": "Bitcoin",
            "symbol": "BTC",
            "website_slug": "bitcoin"
        },
        {
            "id": 2,
            "name": "Litecoin",
            "symbol": "LTC",
            "website_slug": "litecoin"
        },
        ...
    },
    "metadata": {
        "timestamp": 1525137187,
        "num_cryptocurrencies": 1602,
        "error": null
    }
  ]

  ```
  """
  def fetch_listings() do
    get("/listings/")
  end

  def fetch_global_data() do
    get("/global/")
  end

  @doc """
  Returns the global data found at the top of coinmarketcap.com

  Example response:

  ```
  {
    "data": {
        "active_cryptocurrencies": 1594,
        "active_markets": 10526,
        "bitcoin_percentage_of_market_cap": 37.65,
        "quotes": {
            "USD": {
                "total_market_cap": 407690157494.0,
                "total_volume_24h": 30969801118.0
            }
        },
        "last_updated": 1525137271
    },
    "metadata": {
        "timestamp": 1525237332,
        "error": null
    }
  }

  ```
  """
  def fetch_global_data(%{convert: currency}) do
    get("/global/", query: [convert: currency])
  end
end
