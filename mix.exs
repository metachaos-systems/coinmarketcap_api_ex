defmodule CoinmarketcapApi.Mixfile do
  use Mix.Project

  def project do
    [app: :coinmarketcap_api,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: description,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison, :poison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 2.0"},
      {:httpoison, "~> 0.8"},
      {:credo, "~> 0.3", only: [:test,:dev]},
      {:ex_doc, ">= 0.0.0", only: [:dev]}
    ]
  end


  defp description do
    """
    Coinmarketcap.com API wrapper for Elixir/Erlang.
    Provides access to ticker and historical data for cryptocurrencies like Ethereum, Bitcoin, Monero, etc.
    """
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["ontofractal"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/cyberpunk-ventures/coinmarketcap_api_ex"}]
   end

end
