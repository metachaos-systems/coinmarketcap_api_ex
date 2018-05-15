defmodule CoinmarketcapApi.ResponseMiddleware do
  @behaviour Tesla.Middleware
  alias CoinmarketcapApi.Ticker

  def call(env, next, _options) do
    env
    |> Tesla.run(next)
    |> handle_response()
  end

  def handle_response(response) do
    # {:ok, env_test} = response
    # IO.inspect Map.keys(env_test)
    with {:ok, env = %{body: %{"data" => data, "metadata" => meta}, url: url}} <- response do
      data =
        if is_ticker_endpoint?(url) do
          construct_tickers(data)
        else
          data
        end

      {:ok, %{data: data, metadata: meta}}
    else
      err -> err
    end
  end

  def is_ticker_endpoint?(url) do
    String.contains?(url, "/v2/ticker/")
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
