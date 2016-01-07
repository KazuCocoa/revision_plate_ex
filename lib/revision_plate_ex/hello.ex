defmodule RevisionPlateEx.Hello do
  @moduledoc """
  Hello revision module
  """
  import Plug.Conn

  @revision_file "REVISION"

  @type conn :: %Plug.Conn{}

  @spec revision(conn) :: conn
  def revision(conn) do
    {status, message} = read_revision
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(status, message)
  end

  defp read_revision do
    case File.read(revision_file) do
      {:ok, message} ->
        {200, message}
      {:error, _} ->
        {404, "not found #{@revision_file} file"}
    end
  end

  defp revision_file do
    Application.get_env :revision_plate_ex, :file_path, @revision_file
  end
end
