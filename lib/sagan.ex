defmodule Sagan do
  @moduledoc """
  Documentation for Sagan.
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
