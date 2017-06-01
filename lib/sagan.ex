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
      hostname: "host.documents.azure.com",
      database: "your-database",
      name: :mongo, # to name the process
      username: "your-username",
      password: "your-key",
      port: 10255
    ```

    Provides and simplifies all the functions of [MongoDB](https://hexdocs.pm/mongodb/Mongo.html)
  """
  alias Sagan.API
  
  @database Application.get_env(:sagan, :database)
  @conn Application.get_env(:sagan, :name)
  @default_opts [pool: DBConnection.Poolboy]

  def create_document(collection, document) do
    "dbs/#{@database}/colls/#{collection}/docs"
    |> API.post(document)
  end

  def get_document_by_id(collection, id) do
    "dbs/#{@database}/colls/#{collection}/docs/#{id}"
    |> API.get()
  end

  ###############################
  ## MongoDB Wrapper Functions ##
  ###############################
  
  def aggregate(coll, pipeline, opts \\ []) do
    Mongo.aggregate(@conn, coll, pipeline, opts ++ @default_opts)
  end

  def command(query, opts \\ []) do
    Mongo.command(@conn, query, opts ++ @default_opts)
  end

  def command!(query, opts \\ []) do
    Mongo.command!(@conn, query, opts ++ @default_opts)
  end

  def count(coll, filter, opts \\ []) do
    Mongo.count(@conn, coll, filter, opts ++ @default_opts)
  end

  def count!(coll, filter, opts \\ []) do
    Mongo.count!(@conn, coll, filter, opts ++ @default_opts)
  end

  def delete_many(coll, filter, opts \\ []) do
    Mongo.delete_many(@conn, coll, filter, opts ++ @default_opts)
  end

  def delete_many!(coll, filter, opts \\ []) do
    Mongo.delete_many!(@conn, coll, filter, opts ++ @default_opts)
  end

  def delete_one(coll, filter, opts \\ []) do
    Mongo.delete_one(@conn, coll, filter, opts ++ @default_opts)
  end

  def delete_one!(coll, filter, opts \\ []) do
    Mongo.delete_one!(@conn, coll, filter, opts ++ @default_opts)
  end

  def distinct(coll, field, filter, opts \\ []) do
    Mongo.distinct(@conn, coll, field, filter, opts ++ @default_opts)
  end

  def distinct!(coll, field, filter, opts \\ []) do
    Mongo.distinct!(@conn, coll, field, filter, opts ++ @default_opts)
  end

  def find(coll, filter, opts \\ []) do
    Mongo.find(@conn, coll, filter, opts ++ @default_opts)
  end

  def find_one(coll, filter, opts \\ []) do
    Mongo.find_one(@conn, coll, filter, opts ++ @default_opts)
  end

  def find_one_and_delete(coll, filter, opts \\ []) do
    Mongo.find_one_and_delete(@conn, coll, filter, opts ++ @default_opts)
  end

  def find_one_and_replace(coll, filter, replacement, opts \\ []) do
    Mongo.find_one_and_replace(@conn, coll, filter, replacement, opts ++ @default_opts)
  end

  def find_one_and_update(coll, filter, update, opts \\ []) do 
    Mongo.find_one_and_update(@conn, coll, filter, update, opts ++ @default_opts)
  end

  def insert_many(coll, docs, opts \\ []) do
    Mongo.insert_many(@conn, coll, docs, opts ++ @default_opts)
  end

  def insert_many!(coll, docs, opts \\ []) do
    Mongo.insert_many!(@conn, coll, docs, opts ++ @default_opts)
  end

  def insert_one(coll, doc, opts \\ []) do
    Mongo.insert_one(@conn, coll, doc, opts ++ @default_opts)
  end

  def insert_one!(coll, doc, opts \\ []) do
    Mongo.insert_one!(@conn, coll, doc, opts ++ @default_opts)
  end

  def replace_one(coll, filter, replacement, opts \\ []) do
    Mongo.replace_one(@conn, coll, filter, replacement, opts ++ @default_opts)  
  end

  def replace_one!(coll, filter, replacement, opts \\ []) do
    Mongo.replace_one!(@conn, coll, filter, replacement, opts ++ @default_opts)  
  end

  def update_many(coll, filter, update, opts \\ []) do
    Mongo.update_many(@conn, coll, filter, update, opts ++ @default_opts)
  end 

  def update_many!(coll, filter, update, opts \\ []) do
    Mongo.update_many!(@conn, coll, filter, update, opts ++ @default_opts)
  end 

  def update_one(coll, filter, update, opts \\ []) do
    Mongo.update_one(@conn, coll, filter, update, opts ++ @default_opts)
  end

  def update_one!(coll, filter, update, opts \\ []) do
    Mongo.update_one!(@conn, coll, filter, update, opts ++ @default_opts)
  end
end
