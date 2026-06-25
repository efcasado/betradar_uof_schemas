defmodule UOF.Schemas.MixProject do
  use Mix.Project

  def project do
    [
      app: :uof_schemas,
      version: "0.2.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      description: description(),
      package: package(),
      source_url: "https://github.com/efcasado/betradar_uof_schemas",
      docs: docs()
    ]
  end

  def cli do
    [
      preferred_envs: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.github": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.12"},
      {:saxy, "~> 1.5"},
      {:req, "~> 0.6.2", only: :dev},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:styler, "~> 1.2", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:junit_formatter, "~> 3.3", only: :test}
    ]
  end

  defp description do
    "Ecto embedded schemas and a generic XML decoder for Betradar's Unified Odds Feed (UOF), " <>
      "generated from the official .NET SDK XSDs."
  end

  defp package do
    [
      name: "uof_schemas",
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE CHANGELOG.md),
      licenses: ~w(MIT),
      links: %{
        "GitHub" => "https://github.com/efcasado/betradar_uof_schemas",
        "Changelog" => "https://github.com/efcasado/betradar_uof_schemas/blob/main/CHANGELOG.md"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  # `codegen/` (XSD -> Ecto schema generation) is a dev-only concern and must
  # never be compiled into the published package; consumers compile only `lib/`.
  defp elixirc_paths(:dev), do: ["lib", "codegen"]
  defp elixirc_paths(_), do: ["lib"]
end
