# Sagan 
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()

Azure Cosmos DB Driver for Elixir

## Features
  
  * Connects to Azure Cosmos DB through their REST API
  * Supports basic CREATE and READ for documents

## Immediate Roadmap
  
  * Expand to support all CRUD for databases, collections, and documents 
  * Support Cosmos DB's ability to use SQL queries
  * Develop comprehensive documentation

## Tentative Roadmap

  * Switch from REST to TCP. Not a lot of documentation around this so not sure if it will work.
  * Use docker image for local development and testing. Only Cosmos DB emulator available is for Windows.

## Usage

### Installation

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

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sagan](https://hexdocs.pm/sagan).



