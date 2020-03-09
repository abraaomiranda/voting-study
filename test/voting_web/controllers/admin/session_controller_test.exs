defmodule VotingWeb.Admin.SessionControllerTest do

  use VotingWeb.ConnCase, async: true

  import Voting.Factory

  describe "create/2" do
    setup %{conn: conn}do
      insert(:admin, name: "John Wick", email: "john_wick@gmail.com")

      %{conn: conn, path: "api/v1/admin/sign_in"}
    end

    test "returns 200 when admin credentials are valid", %{conn: conn, path: path} do
      conn = post(conn, path, %{"email" => "john_wick@gmail.com", "password" => "123456"})

      assert %{"status" => "ok", "data" => %{"name" => "John Wick"}} = json_response(conn, 200)
      refute [] == get_resp_header(conn, "jwt_token")
    end

    test "return error when admin email is not valid", %{conn: conn, path: path} do
      conn = post(conn, path, %{"email" => "john_johnk@gmail.com", "password" => "123456"})

      assert %{"status" => "unauthorized"} = json_response(conn, 401)
    end

    test "return error when admin password is not valid", %{conn: conn, path: path} do
      conn = post(conn, path, %{"email" => "john_wick@gmail.com", "password" => "12345678"})

      assert %{"status" => "unauthorized"} = json_response(conn, 401)
    end
  end
end
