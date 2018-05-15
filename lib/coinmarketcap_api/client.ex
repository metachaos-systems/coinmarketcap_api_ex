defmodule CoinmarketcapApi.V2Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.coinmarketcap.com/v2"
  plug Tesla.Middleware.JSON

  def fetch_ticker(id, query) do
    get("/ticker/#{id}", query)
  end

  def fetch_ticker(query \\ []) do
    get("/ticker", query)
  end

  def fetch_listings() do
    get("/listings/")
  end

  def fetch_global_data() do
    get("/global/")
  end

  def fetch_global_data(%{convert: currency}) do
    get("/global", [convert: currency])
  end

end
