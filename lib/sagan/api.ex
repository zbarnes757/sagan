defmodule Sagan.API do
  use Timex

  @host Application.get_env(:sagan, :host)
  @master_key Application.get_env(:sagan, :master_key) |> Base.decode64!()
  @resource_types ["dbs", "colls", "docs"]

  def post(path, body) do
    path
    |> build_url()
    |> HTTPoison.post(Poison.encode!(body), headers(path, "post"), ssl: [{:versions, [:'tlsv1.2']}])
    |> parse_response()
  end

  def get(path) do
    path
    |> build_url()
    |> HTTPoison.get(headers(path, "get"), ssl: [{:versions, [:'tlsv1.2']}])
    |> parse_response()
  end

  # Helper Function

  defp build_url(path), do: "https://#{@host}/#{path}"

  defp headers(path, method) do
    now = get_now()

    [
      {"Authorization", auth(now, path, method)},
      {"Accept", "application/json"},
      {"x-ms-date", now},
      {"x-ms-version", "2017-02-22"}
    ]
  end

  defp auth(now, path, method) do
    resource_type = build_resource_type(path)
    resource_link = build_resource_link(path)

    body = "#{method}\n#{resource_type}\n#{resource_link}\n#{now}\n\n"
    
    signature = 
      :sha256
      |> :crypto.hmac(@master_key, body)
      |> Base.encode64()
    
    URI.encode_www_form("type=master&ver=1.0&sig=#{signature}")
  end

  defp build_resource_type(path) do
    path
    |> String.split("/")
    |> Enum.reverse()
    |> get_resource_type()
  end

  defp build_resource_link(path) do
    path
    |> String.split("/")
    |> Enum.reverse()
    |> filter_resource_link()
    |> Enum.reverse()
    |> Enum.join("/")
  end

  defp get_resource_type([h | _t]) when h in @resource_types, do: h
  defp get_resource_type([_h | t]), do: get_resource_type(t)

  defp filter_resource_link([h | t]) when h in @resource_types, do: t
  defp filter_resource_link(list), do: list

  defp get_now() do
     DateTime.utc_now()
     |> Timezone.convert("GMT")
     |> Timex.format!("%a, %d %b %Y %H:%M:%S %Z", :strftime)
     |> String.downcase()
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: Poison.decode(body)
  defp parse_response({:ok, %HTTPoison.Response{status_code: 201, body: body}}), do: Poison.decode(body)
  defp parse_response({:ok, %HTTPoison.Response{body: body}}), do: Poison.decode(body)
  defp parse_response({:error, %HTTPoison.Error{reason: reason}}), do: {:error, reason}
  defp parse_response(_), do: {:error, "Unknown error occured during api call."}
end