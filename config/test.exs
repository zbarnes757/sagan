use Mix.Config

config :sagan,
  hostname: System.get_env("HOSTNAME"),
  database: "test",
  name: :mongo,
  username: System.get_env("USERNAME"),
  password: System.get_env("PASSWORD"),
  port: 10255,
  pool: DBConnection.Poolboy,
  type: :single,
  set_name: "globaldb",
  ssl: true,
  ssl_opts: [{:versions, [:'tlsv1.2']}] 

import_config "test.secret.*"