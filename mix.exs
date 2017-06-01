defmodule Sagan.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sagan,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      preferred_cli_env: [
        espec: :test,
        vcr: :test
      ],
      description: description(),
      package: package(),
      name: "Sagan",
      source_url: "https://github.com/zbarnes757/sagan"
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Sagan.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11.2"},
      {:timex, "~> 3.1"},
      {:poison, "~> 3.1"},

      # Test and Dev deps
      {:espec, "~> 1.4.0", only: :test},
      {:exvcr, "~> 0.8", only: :test},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:mock, "~> 0.2.1", only: :test}
    ]
  end


  defp description do
    """
    Azure Cosmos DB driver for Elixir
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :sagan,
      files: ["lib", "mix.exs", "README.md", "LICENSE",],
      maintainers: ["Zac Barnes"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/zbarnes757/sagan"}
    ]
  end
end
