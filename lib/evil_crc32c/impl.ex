defmodule EvilCrc32c.Impl do
  @moduledoc false

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :evil_crc32c,
    crate: :evil_crc32c,
    base_url: "https://github.com/ayrat555/evil_crc32c/releases/download/v#{version}",
    force_build: System.get_env("EVIL_CRC32C_BUILD") in ["1", "true"],
    version: version

  def calc_crc32c(_data), do: :erlang.nif_error(:nif_not_loaded)
  def calc_crc16(_data), do: :erlang.nif_error(:nif_not_loaded)
end
