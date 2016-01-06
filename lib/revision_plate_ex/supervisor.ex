defmodule RevisionPlateEx.Supervisor do
  @moduledoc """
  Return REVISON
  """
  use Supervisor
  alias RevisionPlateEx.Router

  def start_link, do: Supervisor.start_link __MODULE__, :ok, [name: __MODULE__]

  def init(:ok) do

    port = Application.get_env :revision_plate_ex, :http_port, 4000

    children = [
      worker(Router, [port], [])
    ]

    supervise children, strategy: :one_for_one
  end
end
