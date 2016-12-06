defmodule RevisionPlateEx.Router do
  @moduledoc """
  Define RevisionPlateEx Router.
  This module defines `get` and `head` methods via `Plug.Router` as standalone server. When anyone access to these methods , then this server return `REVISION` and status code as response.

  To start this server, please set `:revision_plate_ex` as `application` in `MyApp.Mixfile` as example. After start `MyApp`, then `:revision_plate_ex` works automatically and start to return revision.

  ## Example

      defmodule MyApp.Mixfile do
        use Mix.Project

        def project do
          ...
        end

        def application do
          [
            applications: [:revision_plate_ex],
          ]
        end

        ...
      end


  This standalone server support two configurations. One is `:http_port` and another is `:file_path`. `:http_port` is listening port and `:file_path` is custom path to return response from.

  These configuration is optional. Defaults are `4000` for `:http_port` and `REVISION` for `:file_path`.

  ## Example

      use Mix.Config

      config :revision_plate_ex,
        http_port: 8000,
        file_path: "REVISION"
  """
  use Plug.Router
  alias RevisionPlateEx.Hello

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  @spec start_link(integer) :: {:ok, pid}
  def start_link(port) do
    Plug.Adapters.Cowboy.http(__MODULE__, [], [port: port])
  end

  match "/hello/revision", via: [:get, :head] do
    Hello.revision conn
  end
end
