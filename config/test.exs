use Mix.Config

config :sagan, 
  host: System.get_env("HOST"),
  database: System.get_env("DATABASE"),
  master_key: System.get_env("MASTER_KEY")

import_config "test.secret.*"