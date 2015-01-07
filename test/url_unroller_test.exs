defmodule UrlUnrollerTest do
  use ExUnit.Case

  import UrlUnroller

  test "unrolling a shortened link" do
    assert unroll("http://bit.ly/1Bx0zo8") == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling an invalid link" do
    { status, _ } = unroll("http://bit.ly/fdskljfldksjfdsklj")
    assert status == :error
  end
end
