defmodule AppBancoDados.MixProject do
  use Mix.Project

  def project do
    [
      app: :app_banco_dados,
      version: "0.1.0",
      elixir: "~> 1.7",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      escript: [main_module: AppBancoDados.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {AppBancoDados.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 4.0",override: true},
      {:httpoison, "~> 1.2"},
      {:ecto, "~> 2.2"}
    ]
  end
end
