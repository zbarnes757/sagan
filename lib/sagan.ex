defmodule Sagan do
  @moduledoc """
    Azure Cosmos DB Driver for Elixir

    Installation
    -------------
    
    If [available in Hex](https://hex.pm/docs/publish), the package can be installed
    by adding `sagan` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:sagan, "~> 0.1.0"}]
    end

    # in your config.exs
    config :sagan,
      master_key: "your-key",
      host: "host.documents.azure.com", # Azure has it listed under keys as 'https://host.documents.azure.com:443/'
      database: "your-database"
    ```
  """
  alias Sagan.API
  
  @database Application.get_env(:sagan, :database)

  def create_document(collection, document) do
    "dbs/#{@database}/colls/#{collection}/docs"
    |> API.post(document)
  end

  def get_document_by_id(collection, id) do
    "dbs/#{@database}/colls/#{collection}/docs/#{id}"
    |> API.get()
  end
end
