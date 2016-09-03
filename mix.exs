defmodule RevisionPlateEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :revision_plate_ex,
      version: "0.1.0",
      elixir: "~> 1.3",
      name: "RevisionPlateEx",
      source_url: "https://github.com/KazuCocoa/revision_plate_ex",
      description: "Plug application and middleware that serves endpoint returns application's REVISION",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      package: package
   ]
  end

  def application do
    [
      applications: [:cowboy, :plug],
      mod: {RevisionPlateEx, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.10", only: :dev}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md LICENSE),
      maintainers: ["Kazuaki Matsuo"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/KazuCocoa/revision_plate_ex"}
    ]
  end
end
