defmodule MarsRoverKata.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_rover_kata,
      version: "0.1.0",
      elixir: "~> 1.11",
      elixirc_options: [warnings_as_errors: true],
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :test,
      aliases: aliases(),
      deps: deps(),
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, "1.5.0", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp aliases do
    [
      ci: ["format --check-formatted", "cs", "check"],
      check: ["credo --strict", "dialyzer --plt"],
      cs: "compile --all-warnings --ignore-module-conflict --debug-info",
      "format.all": "format mix.exs 'lib/**/*.{ex,exs}' 'test/**/*.{ex,exs}' 'config/*.{ex,exs}'",
      test: ["coveralls"]
    ]
  end

  defp dialyzer do
    [
      ignore_warnings: ".dialyzer_ignore.exs",
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/mars_rover_kata.plt"}
    ]
  end
end
