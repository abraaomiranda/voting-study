defmodule VotingWeb.AuthAdmin do
  @moduledoc """
  Authenticate request as admin
  """
  import VotingWeb.Guardian
  import Plug.Conn
  import Voting.Factory

  def authenticate(conn, admin \\ insert(:admin)) do
    {:ok, token, _} = encode_and_sign(admin, %{}, token_type: :access)

    put_req_header(conn, "authorization", "bearer: " <> token)
  end
end
