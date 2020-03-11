defmodule VotingWeb.Admin.ElectionControllerTest do
  use VotingWeb.ConnCase, async: true

  import VotingWeb.AuthAdmin

  describe "create/2" do
    setup %{conn: conn} do
      %{conn: authenticate(conn), path: "api/v1/elections"}
    end

    test "returns 201 when election is created successfully", %{conn: conn, path: path} do
      params = %{
        "name" => "Election",
        "cover" => "url",
        "notice" => "url",
        "starts_at" => ~U[2020-02-01 11:00:00Z],
        "ends_at" => ~U[2020-02-29 11:00:00Z]
      }

      conn = post(conn, path, params)

      assert %{"status" => "ok", "data" => _} = json_response(conn, 201)
    end

    test "return 422 when params are invalid", %{conn: conn, path: path} do
      conn = post(conn, path)

      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end
end
