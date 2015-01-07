UrlUnroller
===========

An example of unrolling short urls in Elixir.

Usage:

```elixir
> {status, result, response_info} = UrlUnroller.unroll("http://bit.ly/1Bx0zo8")
{:ok, "http://blog.semanticart.com/", ...}
```
