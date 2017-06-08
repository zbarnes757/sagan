# Sagan 
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]() [![build](https://travis-ci.org/zbarnes757/sagan.svg?branch=master)]() [![Hex.pm](https://img.shields.io/hexpm/v/sagan.svg)](https://hex.pm/packages/sagan)

Azure Cosmos DB Driver for Elixir. Docs can be found at [https://hexdocs.pm/sagan](https://hexdocs.pm/sagan).

## Features
  
  * Connects to Azure Cosmos DB through MongoDB api (wraps all functions from @ankhers [mongodb driver](https://github.com/ankhers/mongodb))
  * uses poolboy pooling out of the box for all mongodb commands

## Immediate Roadmap

  * Support Cosmos DB's ability to use SQL queries via REST api
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
  [{:sagan, "~> 0.1.1"}]
end

# in your config.exs
config :sagan,
  hostname: "host.documents.azure.com", # Azure has it listed under keys as 'https://host.documents.azure.com:443/'
  database: "your-database",
  name: :mongo, # to name the process
  username: "your-username",
  password: "your-key",
  port: 10255
```

## Contributing

Anyone is welcome to open a pr to help with this project! All I ask that code comes with appropriate tests.

The only caveat to developing on this project right now is that there is no docker image to test against so all tests and development will need to take place against your own database. I recommend creating a database called `test` and a collection called `testDocs` that you can dump as needed. ExVcr should be cleaning your hostnames from the fixtures so if we follow this pattern, there should be no issues as more vcrs get added. Please place all new cassettes in the `fixtures/custom_cassettes` folder and strip out all unnecessary data from your requests. See [existing](https://github.com/zbarnes757/sagan/tree/master/fixture/custom_cassettes) cassettes for examples.



