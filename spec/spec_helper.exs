ESpec.configure fn(config) ->
  config.before fn(tags) ->
    ExVCR.Config.filter_sensitive_data(Application.get_env(:sagan, :hostname), "COSMOS_HOST")

    {:shared, hello: :world, tags: tags}
  end

  config.finally fn(_shared) ->
    :ok
  end
end
