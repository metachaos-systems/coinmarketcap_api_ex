defmodule CoinmarketcapApi do
  use HTTPoison.Base
  @http_opts [timeout: 120_000, recv_timeout: 120_000]
  @api_base_url "https://api.coinmarketcap.com/v1/"

  @doc """
  Intended for coinmarketcap.com for showing historical data
  Returns map with the following keys: marketcap_by_available_supply, prices_btc, prices_usd, volume_usd
  Data is in the format of [time, value] where time is measured in ticks(milliseconds since the start of unix era)
  """
  def fetch_coin_data(name) do
    "https://graphs.coinmarketcap.com/currencies/" <> name <> "/" # slash is canonical path, URL without slash redirects
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_known_coins_data() do
    "https://files.coinmarketcap.com/generated/search/quick_search.json"
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_ticker() do
    ticker_url()
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_ticker(%{start: start, limit: limit}) do
    ticker_url()
      |> Kernel.<>("?start=#{start}&limit=#{limit}")
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_ticker(%{limit: limit}) do
    ticker_url()
      |> Kernel.<>("?limit=#{limit}")
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_ticker(coin) when is_bitstring(coin) do
    ticker_url()
      |> Kernel.<>("#{coin}/")
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_ticker_convert(price) when is_bitstring(price) do
    ticker_url()
      |> Kernel.<>("?convert=#{price}")
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_ticker_convert(coin, price) when is_bitstring(coin) and is_bitstring(price) do
    ticker_url()
      |> Kernel.<>("#{coin}/?convert=#{price}")
      |> get([],@http_opts)
      |> process_result()
  end

  def fetch_global_data() do
    global_url()
      |> get([],@http_opts)
      |> process_result()
  end

  def process_result(result) do
    with {:ok, response} <- result,
      body = response.body,
      do: {:ok, body},
      else: ({:error, reason} -> {:error, reason})
  end

  def process_url(url) do
     url
  end

  defp ticker_url(), do: @api_base_url <> "ticker/"

  defp global_url(), do: @api_base_url <> "global/"

  defp process_request_body(body), do: body

  defp process_response_body(body) do
    body
    |> Poison.decode!
  end

  defp process_request_headers(headers) when is_map(headers) do
    Enum.into(headers, [])
  end

  defp process_request_headers(headers), do: headers

  defp process_response_chunk(chunk), do: chunk

  defp process_headers(headers), do: headers

  defp process_status_code(status_code), do: status_code

end
