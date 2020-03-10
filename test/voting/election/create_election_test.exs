defmodule Voting.CreateElectionTest do
  use Voting.DataCase, async: true

  alias Voting.{CreateElection, Election}

  import Voting.Factory

  describe "run/1" do
    setup do
      %{admin: insert(:admin)}
    end

    test "returns struct when the params are valid", %{admin: admin} do
      params = %{
        name: "Election",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: ~U[2020-02-29 11:00:00Z],
        admin: admin
      }

      assert {:ok, %Election{} = election} = CreateElection.run(params)
      assert election.name == "Election"
      assert election.cover == "url"
      assert election.notice == "url"
      assert election.starts_at == ~U[2020-02-01 11:00:00Z]
      assert election.ends_at == ~U[2020-02-29 11:00:00Z]
      assert election.created_by == admin
    end

    test "returns error when name is missing", %{admin: admin} do
      params = %{
        name: "",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: ~U[2020-02-29 11:00:00Z],
        admin: admin
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is missing", %{admin: admin} do
      params = %{
        name: "Election",
        cover: "url",
        notice: "url",
        starts_at: nil,
        ends_at: ~U[2020-02-29 11:00:00Z],
        admin: admin
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is missing", %{admin: admin} do
      params = %{
        name: "Election",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: nil,
        admin: admin
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is before starts_at", %{admin: admin} do
      params = %{
        name: "Election",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-03-01 11:00:00Z],
        ends_at: ~U[2020-02-29 11:00:00Z],
        admin: admin
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end

    test "returns error when admin is missing" do
      params = %{
        name: "Election",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: ~U[2020-02-29 11:00:00Z],
        admin: nil
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateElection.run(params)
      %{created_by: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
