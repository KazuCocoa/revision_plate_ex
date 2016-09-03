defmodule RevisionPlateEx.Hello do
  @moduledoc """
  Define RevisionPlateEx Hello.
  This module defines functions to generate `%Plug.Conn{}` which have revision plate. To use this feature, you should set as the following example.

  ## Example with `Plug`

      defmodule MyApp.Hello do
        import Plug.Conn

        def sample_revision(conn), do: RevisionPlateEx.Hello.revision conn
      end


  Then `MyApp.Hello.sample_revision/1` return `200` as status code and binary read from `REVISION` file which exists on root path as default. Return `404` and not found message if `REVISION` file doesn't exist.
  """
  import Plug.Conn

  @revision_file "REVISION"

  @type conn :: %Plug.Conn{}

  @doc """
  This function can use with Phoenix like the following. In this case, when anyone access to `/hello/revision` with `GET` method, then return revision with `200` statuscode or not found message with `404`.


  ## Example in `web/router.ex`

      defmodule MyApp.Router do
        use MyApp.Web, :router

        ...

        scope "/", MyApp do
          get "/hello/revision", HelloController, :revision
        end
      end


  ## Example in `web/controllers/hello_controller.ex`

      defmodule MyApp.Hello do
        use MyApp.Web, :controller
        def revision(conn, _opt), do: RevisionPlateEx.Hello.revision conn
      end
  """
  @spec revision(conn) :: conn
  def revision(conn) do
    {status, message} = read_revision()
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
