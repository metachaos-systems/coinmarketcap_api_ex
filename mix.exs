defmodule CoinmarketcapApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :coinmarketcap_api,
      version: "2.0.1",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      compilers: Mix.compilers(),
      package: package(),
      description: description(),
      deps: deps()
    ]
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
      {:poison, "~> 3.0"},
      {:httpoison, "~> 1.0"},
      {:credo, "~> 0.3", only: [:test, :dev]},
      {:ex_doc, ">= 0.0.0", only: [:dev]},
      {:tesla, "~> 1.0.0"},
      {:jason, ">= 1.0.0"},
      {:exconstructor, "~> 1.0"}
    ]
  end

  defp description do
    """
    Coinmarketcap.com v2 API client for Elixir/Erlang.
    Provides access to ticker and historical data for cryptocurrencies like Ethereum, Bitcoin, Monero, etc.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["ontofractal"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/cyberpunk-ventures/coinmarketcap_api_ex",
        "Cyberpunk Ventures" => "https://cyberpunk.ventures"
      }
    ]
  end
end
