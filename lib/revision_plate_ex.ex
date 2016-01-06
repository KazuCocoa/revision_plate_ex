defmodule RevisionPlateEx do
  @moduledoc """
  Return REVISON
  """
  use Application

  def start(_type, _args), do: RevisionPlateEx.Supervisor.start_link
end
