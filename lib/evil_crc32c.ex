defmodule EvilCrc32c do
  @moduledoc """
  "Evil" version of the crc32c algorithm. It uses the bitwise arithmetic used in javascript,
  i.e. operands are converted to i32
  """
  alias EvilCrc32c.Impl

  @doc """
  Calculate the CRC.

  Expect binary data.

  #### Examples

      iex> EvilCrc32c.calc(<<1, 2, 3, 4>>)
      {:ok, <<244, 140, 48, 41>>}

      iex> EvilCrc32c.calc(5)
      {:error, :not_binary_data}

      iex> EvilCrc32c.calc("hello", false)
      {:ok, -1703822516}

      iex> EvilCrc32c.calc("hello", true)
      {:ok, <<76, 187, 113, 154>>}
  """
  @spec calc(binary(), boolean()) :: {:ok, integer() | binary()} | {:error, :not_binary_data}
  def calc(data, binary \\ true)

  def calc(data, binary) when is_binary(data) do
    result = do_calc(data, binary)

    {:ok, result}
  end

  def calc(_data, _flag) do
    {:error, :not_binary_data}
  end

  @doc """
  Calculate the CRC. Raises an Argument error if data is not binary

  Expect binary data.

  #### Examples

      iex> EvilCrc32c.calc!(<<1, 2, 3, 4>>)
      <<244, 140, 48, 41>>

      iex> EvilCrc32c.calc!("hello", false)
      -1703822516

      iex> EvilCrc32c.calc!("hello", true)
      <<76, 187, 113, 154>>
  """
  @spec calc(binary(), boolean()) :: integer() | binary() | no_return()
  def calc!(data, binary \\ true)

  def calc!(data, binary) do
    do_calc(data, binary)
  end

  defp do_calc(data, binary) do
    number = Impl.calc(data)

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
