defmodule RevisionPlateEx.Router do
  @moduledoc """
  Standalone
  """
  use Plug.Router
  alias RevisionPlateEx.Hello

  @revision_file "REVISION"

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
