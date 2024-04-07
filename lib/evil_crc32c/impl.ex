defmodule EvilCrc32c.Impl do
  @moduledoc false

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :evil_crc32c,
    crate: :evil_crc32c,
    base_url: "https://github.com/ayrat555/evil_crc32c/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_BUILD") in ["1", "true"],
    targets: Enum.uniq(["x86_64-unknown-freebsd" | RustlerPrecompiled.Config.default_targets()]),
    nif_versions: ["2.15", "2.16"],
    version: version

  def calc_crc32c(_data), do: :erlang.nif_error(:nif_not_loaded)
  def calc_crc16(_data), do: :erlang.nif_error(:nif_not_loaded)
end
