defmodule Voting.UpdateElectionTest do
  use Voting.DataCase, async: true

  alias Voting.{Election, UpdateElection}

  import Voting.Factory

  describe "run/1" do
    setup do
      %{election: insert(:election)}
    end

    test "returns struct when the params are valid", %{election: election} do
      params = %{
        "name" => "Updated Name",
        "cover" => "Updated Cover",
        "notice" => "Updated Notice"
      }

      assert {:ok, %Election{} = updated_election} = UpdateElection.run(election, params)
      assert updated_election.id == election.id
      assert updated_election.name == "Updated Name"
      assert updated_election.cover == "Updated Cover"
      assert updated_election.notice == "Updated Notice"
    end

    test "returns error when name is missing", %{election: election} do
      params = %{
        "name" => ""
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is missing", %{election: election} do
      params = %{
        "starts_at" => nil
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is missing", %{election: election} do
      params = %{
        "ends_at" => nil
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is before starts_at", %{election: election} do
      params = %{
        "starts_at" => ~U[2020-03-01 11:00:00Z],
        "ends_at" => ~U[2020-02-29 11:00:00Z]
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateElection.run(election, params)
      %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end
  end
end
