defmodule RevisionPlateExTest do
  use ExUnit.Case
  use Plug.Test

  alias RevisionPlateEx.Router

  test "subversion tree" do
    pid = Process.whereis RevisionPlateEx.Supervisor
    assert is_pid(pid) == true

    children = Supervisor.which_children RevisionPlateEx.Supervisor
    {id, _, _, modules} = hd(children)

    assert Enum.count(children) == 1
    assert id == Router
    assert modules == [Router]
  end

  test "find REVISION file and return hello with get" do
    File.write "REVISION", "hello"

    conn = conn(:get, "/hello/revision")
           |> Router.call([])
    assert conn.status == 200
    assert conn.resp_body == "hello"

    File.rm "REVISION"
  end

  test "not found REVISION file with get" do
    File.rm "REVISION"

    conn = conn(:get, "/hello/revision")
           |> Router.call([])
    assert conn.status == 404
    assert conn.resp_body == "not found REVISON file"
  end

  test "find REVISION file and return hello with head" do
    File.write "REVISION", "hello"

    conn = conn(:head, "/hello/revision")
           |> Router.call([])
    assert conn.status == 200
    assert conn.resp_body == ""

    File.rm "REVISION"
  end

  test "not found REVISION file with head" do
    File.rm "REVISION"

    conn = conn(:head, "/hello/revision")
           |> Router.call([])
    assert conn.status == 404
    assert conn.resp_body == ""
  end

  test "find REVISION file with custom path and return hello with get" do
    custom_file = "CUSTOM_FILE"
    Application.put_env :revision_plate_ex, :file_path, custom_file
    File.write custom_file, "custom hello"

    conn = conn(:get, "/hello/revision")
           |> Router.call([])
    assert conn.status == 200
    assert conn.resp_body == "custom hello"

    File.rm custom_file
    Application.put_env :revision_plate_ex, :file_path, "REVISION"
  end
end
