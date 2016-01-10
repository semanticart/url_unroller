defmodule UrlUnroller.Mixfile do
  use Mix.Project

  def project do
    [app: :url_unroller,
     version: "0.0.2",
     elixir: "~> 1.0",
     deps: deps,

     name: "UrlUnroller",
     source_url: "https://github.com/semanticart/url_unroller",
     homepage_url: "https://github.com/semanticart/url_unroller",

     # hex
     package: package,
     description: "A simple url unroller/unshortener"
   ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:httpoison, "~> 0.8.0"},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.6", only: :dev}]
  end

  defp package do
    [maintainers: ["Jeffrey Chupp"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/semanticart/url_unroller"}]
  end
end
