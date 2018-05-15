defmodule CoinmarketcapApi.ResponseMiddleware do
  @behaviour Tesla.Middleware
  alias CoinmarketcapApi.{Ticker, Response, GlobalData}

  def call(env, next, _options) do
    env
    |> Tesla.run(next)
    |> handle_response()
  end

  def handle_response(response) do
    with {:ok, env = %{body: body = %{"data" => data, "metadata" => meta}, url: url}} <- response do
      cmc_response =
        body
        |> Response.new()
        |> build_structs(url)

      {:ok, cmc_response}
    else
      err -> err
    end
  end

  @doc """
  Matches endpoints and converts to corresponding structs
  """
  def build_structs(response, url) do
    data =
      cond do
        is_ticker_endpoint?(url) -> construct_tickers(response.data)
        is_global_data_endpoint?(url) -> GlobalData.new(response.data)
        true -> response.data
      end

    Map.put(response, :data, data)
  end

  def is_ticker_endpoint?(url) do
    String.contains?(url, "/v2/ticker/")
  end

  def is_global_data_endpoint?(url) do
    String.contains?(url, "/v2/global/")
  end

  defp construct_tickers(data) do
    if is_nil(data["id"]) do
      for {k, v} <- data, into: %{} do
        {k, construct_tickers(v)}
      end
    else
      construct_ticker(data)
    end
  end

  defp construct_ticker(datum) do
    datum
    |> Ticker.new()
    |> Ticker.parse()
  end
end
