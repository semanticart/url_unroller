defmodule UrlUnroller do
  @user_agent [ {"User-agent", "UrlUnroller jeff@semanticart.com"} ]

  def unroll(url) do
    fetch(HTTPoison.head(url, @user_agent), url)
  end

  defp fetch({:ok, response}, url) do
    handle(normalize_status_code(response), url, response)
  end
  defp fetch({status, response}, url) do
    {:error, url, {status, response}}
  end

  defp handle(300, _, response) do
    unroll(location(response))
  end
  defp handle(200, url, response) do
    {:ok, url, {:ok, response}}
  end
  defp handle(normalized_status_code, url, response) when normalized_status_code == 400 or normalized_status_code == 500 do
    {:error, url, {:ok, response}}
  end

  # bitly returns capital-L location while t.co is lowercase
  defp location(response) do
    response.headers["Location"] || response.headers["location"]
  end

  defp normalize_status_code(response) do
    div(response.status_code, 100) * 100
  end
end
