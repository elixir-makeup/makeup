defmodule Sandbox.Mixfile do
  use Mix.Project

  def project do
    [
      app: :makeup,
      version: "0.1.2",
      elixir: "~> 1.0",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      # Docs
      name: "Makeup",
      source_url: "https://github.com/tmbb/makeup",
      homepage_url: "https://github.com/tmbb/makeup",
      docs: [main: "Makeup", # The main page in the docs
             extras: ["README.md"]],
      # Package
      package: package(),
      description: description()
    ]
  end

  defp description do
    """
    Syntax highlighter for source code in the style of Pygments.
    """
  end

  defp package do
    [
      name: :makeup,
      licenses: ["BSD"],
      maintainers: ["Tiago Barroso <tmbb@campus.ul.pt>"],
      links: %{"GitHub" => "https://github.com/tmbb/makeup"}
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
      {:ex_spirit, "~> 0.3.0"},
      {:ex_const, "~> 0.1.0"},
      {:exconstructor, "~> 1.1.0"},
      {:html_entities, "~> 0.3.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
      #{:ex_doc, path: "../ex_doc", only: :dev, runtime: false}
    ]
  end
end
