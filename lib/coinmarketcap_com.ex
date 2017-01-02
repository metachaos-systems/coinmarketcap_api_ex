defmodule CoinmarketcapApi do
  use HTTPoison.Base

  @doc """
  Intended for coinmarketcap.com for showing historical data
  Returns map with the following keys: marketcap_by_available_supply, prices_btc, prices_usd, volume_usd
  Data is in the format of [time, value] where time is measured in ticks(milliseconds since the start of unix era)
  """
  def fetch_coin_data(name) do
    "https://api.coinmarketcap.com/v1/datapoints/" <> name <> "/" # slash is canonical path, URL without slash redirects
    |> get()
    |> process_result()
  end

  def fetch_known_coins_data() do
    "https://files.coinmarketcap.com/generated/search/quick_search.json"
    |> get()
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
