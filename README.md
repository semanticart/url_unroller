UrlUnroller
===========

An example of unrolling short urls in Elixir.

Depends on [HTTPoison](https://hex.pm/packages/httpoison) running as an application. e.g. in your mix.exs

```elixir
  def application do
    [applications: [:logger, :httpoison]]
  end
```

Usage:

```elixir
> {status, result, response_info} = UrlUnroller.unroll("http://bit.ly/1Bx0zo8")
{:ok, "http://blog.semanticart.com/", ...}
```
