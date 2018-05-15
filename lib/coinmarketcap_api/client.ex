defmodule CoinmarketcapApi.V2Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.coinmarketcap.com/v2"
  plug CoinmarketcapApi.ResponseMiddleware
  plug Tesla.Middleware.JSON

  def fetch_ticker() do
    get("/ticker/")
  end

  def fetch_ticker(query) when is_list(query) do
    get("/ticker/", query: query)
  end

  def fetch_ticker(opts) when is_map(opts) do
    query = Map.to_list(opts)
    get("/ticker/", query: query)
  end

  def fetch_ticker(id, query \\ []) do
    get("/ticker/#{id}/", query: query)
  end


  def fetch_listings() do
    get("/listings/")
  end

  def fetch_global_data() do
    get("/global/")
  end

  def fetch_global_data(%{convert: currency}) do
    get("/global/", query: [convert: currency])
  end


end
