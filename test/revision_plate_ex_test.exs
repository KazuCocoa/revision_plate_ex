defmodule RevisionPlateExTest do
  use ExUnit.Case, async: true
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

  describe "with finding REVISION" do
    setup do
      File.write "REVISION", "hello"
      on_exit fn -> File.rm "REVISION" end
      :ok
    end

    test "return hello with get" do
      conn = conn(:get, "/hello/revision")
             |> Router.call([])
      assert conn.status == 200
      assert conn.resp_body == "hello"
    end

    test "no body with head" do
      conn = conn(:head, "/hello/revision")
             |> Router.call([])
      assert conn.status == 200
      assert conn.resp_body == ""
    end
  end

  describe "with finding no REVISION" do
    setup do
      File.rm "REVISION"
      :ok
    end

    test "not found with get" do
      conn = conn(:get, "/hello/revision")
             |> Router.call([])
      assert conn.status == 404
      assert conn.resp_body == "not found REVISION file"
    end

    test "not found with head" do
      conn = conn(:head, "/hello/revision")
             |> Router.call([])
      assert conn.status == 404
      assert conn.resp_body == ""
    end
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
