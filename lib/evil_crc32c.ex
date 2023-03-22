defmodule EvilCrc32c do
  @moduledoc """
  "Evil" versions of the crc32c and crc16 algorithm. It uses the bitwise arithmetic used in javascript,
  i.e. operands are converted to i32
  """
  alias EvilCrc32c.Impl

  @doc """
  Calculate the CRC32C.

  #### Examples

      iex> EvilCrc32c.crc32c(<<1, 2, 3, 4>>)
      {:ok, <<244, 140, 48, 41>>}

      iex> EvilCrc32c.crc32c(5)
      {:error, :not_binary_data}

      iex> EvilCrc32c.crc32c("hello", false)
      {:ok, -1703822516}

      iex> EvilCrc32c.crc32c("hello", true)
      {:ok, <<76, 187, 113, 154>>}
  """
  @spec crc32c(binary(), boolean()) :: {:ok, integer() | binary()} | {:error, :not_binary_data}
  def crc32c(data, binary \\ true)

  def crc32c(data, binary) when is_binary(data) do
    result = do_crc32c(data, binary)

    {:ok, result}
  end

  def crc32c(_data, _flag) do
    {:error, :not_binary_data}
  end

  @doc """
  Calculate the CRC32C. Raises an Argument error if data is not binary

  #### Examples

      iex> EvilCrc32c.crc32c!(<<1, 2, 3, 4>>)
      <<244, 140, 48, 41>>

      iex> EvilCrc32c.crc32c!("hello", false)
      -1703822516

      iex> EvilCrc32c.crc32c!("hello", true)
      <<76, 187, 113, 154>>
  """
  @spec crc32c!(binary(), boolean()) :: integer() | binary() | no_return()
  def crc32c!(data, binary \\ true)

  def crc32c!(data, binary) do
    do_crc32c(data, binary)
  end

  @doc """
  Calculate the CRC16.

  #### Examples

      iex> EvilCrc32c.crc16("abcdef")
      <<58, 253>>
  """
  @spec crc16(binary()) :: binary()
  def crc16(data) do
    reg = Impl.calc_crc16(data)

    remainder = rem(reg, 256)
    floor_div = Float.floor(reg / 256.0) |> trunc()

    <<floor_div, remainder>>
  end

  defp do_crc32c(data, binary) do
    number = Impl.calc_crc32c(data)

    if binary do
      to_binary(number)
    else
      number
    end
  end

  defp to_binary(integer) do
    <<integer::32-little>>
  end
end
