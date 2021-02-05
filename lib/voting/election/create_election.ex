defmodule Voting.CreateElection do
  @moduledoc """
  Create an election
  """

  import Ecto.Changeset
  import Voting.DateOverlap

  alias Voting.{Election, Repo}

  def run(%{"admin" => admin} = params) do
    %Election{}
    |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at])
    |> put_assoc(:created_by, admin)
    |> validate_required([:name, :starts_at, :ends_at, :created_by])
    |> validate_date_overlap(:starts_at, :ends_at)
    |> Repo.insert()
  end
end
