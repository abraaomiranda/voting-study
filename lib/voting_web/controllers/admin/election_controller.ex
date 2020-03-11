defmodule VotingWeb.Admin.ElectionController do
  use VotingWeb, :controller

  alias Voting.CreateElection
  alias VotingWeb.Guardian.Plug

  def create(conn, params) do
    admin = Plug.current_resource(conn)

    case CreateElection.run(Map.put(params, "admin", admin)) do
      {:ok, election} ->
        conn
        |> put_status(201)
        |> render("election.json", %{election: election})

      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
