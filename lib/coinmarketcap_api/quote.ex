defmodule CoinmarketcapApi.Quote do
  defstruct [
    :market_cap,
    :percent_change_1h,
    :percent_change_24h,
    :percent_change_7d,
    :price,
    :volume_24h
  ]

  use ExConstructor

end
