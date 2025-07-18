defmodule EvilCrc32c.MixProject do
  use Mix.Project

  @version "0.2.9"

  def project do
    [
      app: :evil_crc32c,
      version: @version,
      elixir: "~> 1.10",
      description:
        "Evil version of the crc32c algorithm. It uses the bitwise arithmetic used in javascript, i.e. operands are converted to i32",
      start_permanent: Mix.env() == :prod,
      package: [
        maintainers: ["Ayrat Badykov"],
        licenses: ["WTFPL"],
        links: %{"GitHub" => "https://github.com/ayrat555/evil_crc32c"},
        files: [
          "mix.exs",
          "native/evil_crc32c/.cargo/",
          "native/evil_crc32c/src",
          "native/evil_crc32c/Cargo.toml",
          "native/evil_crc32c/Cargo.lock",
          "lib",
          "LICENSE",
          "README.md",
          "CHANGELOG.md",
          "checksum-*.exs"
        ]
      ],
      deps: deps()
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:rustler, ">= 0.0.0", optional: true},
      {:rustler_precompiled, "~> 0.8"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
end
