defmodule VotingWeb.Admin.UploadControllerTest do
  use VotingWeb.ConnCase, async: true
  use Mimic

  import VotingWeb.AuthAdmin

  describe "create/2" do
    setup %{conn: conn} do
      %{conn: authenticate(conn), path: "api/v1/uploads"}
    end

    test "returns 200 when successfully upload the file", %{conn: conn, path: path} do
      expect(ExAws, :request, fn _ -> {:ok, %{status_code: 200}} end)

      params = %{
        "file" => %Plug.Upload{
          content_type: "image/jpeg",
          filename: "file.jpeg",
          path: "/path-to-file"
        }
      }

      conn = post(conn, path, params)

      assert %{"status" => "ok", "data" => %{"url" => _}} = json_response(conn, 200)
    end

    test "return 400 when file is too large", %{conn: conn, path: path} do
      reject(&ExAws.request/1)

      params = %{
        "file" => %Plug.Upload{
          content_type: "image/jpeg",
          filename: "file.jpeg",
          path: "/users/local/images/large_logo.jpg"
        }
      }

      conn = post(conn, path, params)

      assert %{"status" => "file_too_large"} = json_response(conn, 400)
    end

    test "return 400 when failed to upload the file", %{conn: conn, path: path} do
      expect(ExAws, :request, fn _ -> {:error, %{status_code: 500}} end)

      params = %{
        "file" => %Plug.Upload{
          content_type: "image/jpeg",
          filename: "file.jpeg",
          path: "/path-to-file"
        }
      }

      conn = post(conn, path, params)

      assert %{"status" => "upload_error"} = json_response(conn, 400)
    end
  end
end
