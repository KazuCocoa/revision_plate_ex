defmodule RevisionPlateEx.Router do
  @moduledoc """
  Return REVISON
  """
  use Plug.Router
  alias RevisionPlateEx.Router

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  def start_link(port) do
    Plug.Adapters.Cowboy.http(__MODULE__, [], [port: port])
  end

  match "/hello/revision", via: :get do
    {status, message} = revision
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(status, message)
  end

  defp revision do
    {200, "hello"}
  end
end
