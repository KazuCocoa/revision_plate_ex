defmodule RevisionPlateEx.Supervisor do
  @moduledoc false

  use Supervisor
  alias RevisionPlateEx.Router

  def start_link, do: Supervisor.start_link __MODULE__, :ok, [name: __MODULE__]

  def init(:ok) do

    port = to_port(Application.get_env(:revision_plate_ex, :http_port, 4000))

    children = [
      %{
        id: Router,
        start: {Router, :start_link, [port]}
      }
    ]

    Supervisor.init children, strategy: :one_for_one
  end

  defp to_port(binary) when is_binary(binary), do: String.to_integer binary
  defp to_port(integer) when is_integer(integer), do: integer
end
