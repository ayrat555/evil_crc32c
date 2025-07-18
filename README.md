# EvilCrc32c

"Evil" version of the crc32c algorithm. It uses the bitwise arithmetic used in javascript, i.e. operands are converted to i32. It uses a precompiled rust nif.

## Installation

The package can be installed by adding `evil_crc32c` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:evil_crc32c, "~> 0.2.9"}
  ]
end
```

The docs can be found at <https://hexdocs.pm/evil_crc32c>.


## Author

Ayrat Badykov (@ayrat555)
