defmodule RevisionPlateEx do
  @moduledoc """
  Define RevisionPlateEx.
  This module have `start` if `:revision_plate_ex` is defined in `MyApp.Mixfile.application`.
  """
  use Application

  def start(_type, _args), do: RevisionPlateEx.Supervisor.start_link
end
