## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add coinmarketcap_com to your list of dependencies in `mix.exs`:

        def deps do
          [{:coinmarketcap_com, "~> 0.0.1"}]
        end

  2. Ensure coinmarketcap_com is started before your application:

        def application do
          [applications: [:coinmarketcap_com]]
        end
