defmodule Voting.CreateElection do
  @moduledoc """
  Create an election
  """

  import Ecto.Changeset

  alias Voting.{Election, Repo}

  def run(%{"admin" => admin} = params) do
    %Election{}
    |> cast(params, [:name, :cover, :notice, :starts_at, :ends_at])
    |> put_assoc(:created_by, admin)
    |> validate_required([:name, :starts_at, :ends_at, :created_by])
    |> validate_date_overlap()
    |> Repo.insert
  end

  defp validate_date_overlap(%Ecto.Changeset{valid?: true} = changeset) do
    %{starts_at: starts_at, ends_at: ends_at} = changeset.changes

    if DateTime.compare(starts_at, ends_at) == :gt do
      add_error(changeset, :starts_at, "should be before ends_at")
    else
      changeset
    end
  end

  defp validate_date_overlap(%Ecto.Changeset{} = changeset), do: changeset
end
