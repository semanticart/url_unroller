defmodule UrlUnrollerTest do
  use ExUnit.Case

  import UrlUnroller

  test "unrolling a bit.ly link" do
    assert unroll("http://bit.ly/1Bx0zo8") == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling a t.co link" do
    assert unroll("http://t.co/utGcMlSXjD") == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling several layers deep" do
    # hubs.ly -> bit.ly -> t.co -> final destination
    assert unroll("http://hubs.ly/y0qp570") == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling an invalid link" do
    {status, url, response_info} = unroll("http://bit.ly/fdskljfldksjfdsklj")
    assert {status, url} == {:error, "http://bit.ly/fdskljfldksjfdsklj"}

    {_, response} = response_info
    assert response.status_code == 404
  end
end
