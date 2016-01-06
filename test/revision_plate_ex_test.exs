defmodule RevisionPlateExTest do
  use ExUnit.Case
  use Plug.Test
  # doctest RevisionPlateEx

  test "subversion tree" do
    pid = Process.whereis RevisionPlateEx.Supervisor
    assert is_pid(pid) == true

    children = Supervisor.which_children RevisionPlateEx.Supervisor
    {id, _, _, modules} = hd(children)

    assert Enum.count(children) == 1
    assert id == RevisionPlateEx.Router
    assert modules == [RevisionPlateEx.Router]
  end

  test "hello" do
    conn = conn(:get, "/hello/revision")
           |> RevisionPlateEx.Router.call([])
    assert conn.status == 200
    assert conn.resp_body == "hello"
  end

  # TODO:
  # 1. read REVISION file
  # 2. return 404 not found if revision file doesn't exist
end
