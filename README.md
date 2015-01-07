UrlUnroller
===========

An example of unrolling short urls in Elixir.

Usage:

```elixir
> {status, result} = UrlUnroller.unroll("http://bit.ly/1Bx0zo8")
{:ok, "http://blog.semanticart.com/"}
```
