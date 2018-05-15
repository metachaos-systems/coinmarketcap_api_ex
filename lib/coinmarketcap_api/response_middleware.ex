defmodule CoinmarketcapApi.ResponseMiddleware do
  @behaviour Tesla.Middleware

  def call(env, next, options) do
    env
    |> Tesla.run(next)
    |> handle_response()
  end

  def handle_response(response) do
    with {:ok, %{body: %{"data" => data, "metadata" => meta}}} <- response do
      {:ok, %{data: data, metadata: meta}}
    else
      err -> err
    end
  end
end
