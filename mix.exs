defmodule RevisionPlateEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :revision_plate_ex,
      version: "0.4.0",
      elixir: "~> 1.6",
      name: "RevisionPlateEx",
      source_url: "https://github.com/KazuCocoa/revision_plate_ex",
      description: "Plug application and middleware that serves endpoint returns application's REVISION",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package()
   ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {RevisionPlateEx, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.4"},
      {:earmark, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.10", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      files: ~w(lib mix.exs README.md CHANGELOG.md LICENSE),
      maintainers: ["Kazuaki Matsuo"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/KazuCocoa/revision_plate_ex"}
    ]
  end
end
