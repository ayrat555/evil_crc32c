defmodule EvilCrc32c.Impl do
  @moduledoc false

  use Rustler,
    otp_app: :evil_crc32c,
    crate: :evil_crc32c

  def calc(_data), do: :erlang.nif_error(:nif_not_loaded)
end
