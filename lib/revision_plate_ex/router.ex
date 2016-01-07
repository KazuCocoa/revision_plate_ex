defmodule RevisionPlateEx.Router do
  @moduledoc """
  Return REVISON
  """
  use Plug.Router
  alias RevisionPlateEx.Router

  @revision_file "REVISION"

  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  def start_link(port) do
    Plug.Adapters.Cowboy.http(__MODULE__, [], [port: port])
  end

  match "/hello/revision", via: [:get, :head] do
    hello conn
  end

  def hello(conn) do
    {status, message} = revision
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(status, message)
  end

  defp revision do
    case File.read(revision_file) do
      {:ok, message} ->
        {200, message}
      {:error, _} ->
        {404, "not found REVISON file"}
    end
  end

  defp revision_file do
    Application.get_env :revision_plate_ex, :file_path, @revision_file
  end
end
