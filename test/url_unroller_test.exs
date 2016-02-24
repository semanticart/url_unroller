defmodule UrlUnrollerTest do
  use ExUnit.Case
  doctest UrlUnroller

  import UrlUnroller

  test "unrolling a bit.ly link" do
    {status, url, _response_info} = unroll("http://bit.ly/1Bx0zo8")

    assert {status, url} == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling a t.co link" do
    {status, url, _response_info} = unroll("http://t.co/utGcMlSXjD")

    assert {status, url} == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling several layers deep" do
    # hubs.ly -> bit.ly -> t.co -> final destination
    {status, url, _response_info} = unroll("http://hubs.ly/y0qp570")

    assert {status, url} == {:ok, "http://blog.semanticart.com/"}
  end

  test "unrolling an invalid link" do
    {status, url, response_info} = unroll("http://bit.ly/fdskljfldksjfdsklj")
    assert {status, url} == {:error, "http://bit.ly/fdskljfldksjfdsklj"}

    {_response_status, response} = response_info
    assert response.status_code == 404
  end

  test "unrolling an already-unrolled url" do
    {status, url, _response_info} = unroll("http://blog.semanticart.com")

    assert {status, url} == {:ok, "http://blog.semanticart.com"}
  end
end
