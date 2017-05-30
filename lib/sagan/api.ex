defmodule Sagan.API do
  use Timex

  @database Application.get_env(:sagan, :database)
  @host Application.get_env(:sagan, :host)
  @master_key Application.get_env(:sagan, :master_key) |> Base.decode64!()
  @resource_types ["dbs", "colls", "docs"]

  def create_document(collection, document) do
    "dbs/#{@database}/colls/#{collection}/docs"
    |> post(document)
  end

  def get_document_by_id(collection, id) do
    "dbs/#{@database}/colls/#{collection}/docs/#{id}"
    |> get()
  end

  def post(path, body) do
    path
    |> build_url()
    |> HTTPoison.post(Poison.encode!(body), headers(path, "post"), ssl: [{:versions, [:'tlsv1.2']}])
  end

  def get(path) do
    path
    |> build_url()
    |> HTTPoison.get(headers(path, "get"), ssl: [{:versions, [:'tlsv1.2']}])
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

  def filter_resource_link([h | t]) when h in @resource_types, do: t
  def filter_resource_link(list), do: list

  defp get_now() do
     DateTime.utc_now()
     |> Timezone.convert("GMT")
     |> Timex.format!("{WDshort}, {D} {Mshort} {YYYY} {h24}:{m}:{s} {Zabbr}")
     |> String.downcase()
  end
end