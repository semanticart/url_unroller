defmodule UrlUnroller do
  @user_agent [ {"User-agent", "UrlUnroller"} ]

  @doc """
  Returns a long url for a given short url. Also returns the last HTTPoison status and response struct.

  Passing a long url is generally a noop (unless the url is a redirect).

  ## Examples
      iex> {status, url, _response_info} = UrlUnroller.unroll("http://bit.ly/1Bx0zo8")
      iex> {status, url}
      {:ok, "http://blog.semanticart.com/"}

      iex> {status, url, {response_status, response}} = UrlUnroller.unroll("http://semanticart.com/something-that-does-not-exist")
      iex> {status, url, response_status, response.status_code}
      {:error, "http://semanticart.com/something-that-does-not-exist", :ok, 404}
  """
  def unroll(url) do
    fetch(HTTPoison.head(url, @user_agent), url)
  end

  defp fetch({:ok, response}, url) do
    handle(response.status_code, url, response)
  end
  defp fetch({status, response}, url) do
    {:error, url, {status, response}}
  end

  defp handle(status, _, response) when status in 300..399 do
    unroll(location(response))
  end
  defp handle(status, url, response) when status in 100..299 do
    {:ok, url, {:ok, response}}
  end
  defp handle(status, url, response) when status in 400..599 do
    {:error, url, {:ok, response}}
  end

  # bitly returns capital-L location while t.co is lowercase
  defp location(response) do
    {_, url} = response.headers
      |> Enum.find(fn({name, _}) -> String.downcase(name) == "location" end)

    url
  end
end
