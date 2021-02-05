defmodule Voting.DateOverlapTest do
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.DateOverlap

  describe "validate_date_overlap/3" do
    test "returns a valid changeset when the dates are valid" do
      changeset =
        Ecto.Changeset.change(build(:election), %{
          starts_at: ~U[2020-02-01 11:00:00Z],
          ends_at: ~U[2020-02-29 11:00:00Z]
        })

      assert %Ecto.Changeset{valid?: true, errors: []} =
               DateOverlap.validate_date_overlap(changeset, :starts_at, :ends_at)
    end

    test "returns a invalid changeset when the dates are invalid" do
      changeset =
        Ecto.Changeset.change(build(:election), %{
          starts_at: ~U[2020-03-01 11:00:00Z],
          ends_at: ~U[2020-02-29 11:00:00Z]
        })

      assert %Ecto.Changeset{valid?: false} =
               changeset = DateOverlap.validate_date_overlap(changeset, :starts_at, :ends_at)

      assert %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end

    test "returns an invalid changeset when changeset is already invalid" do
      changeset = %Ecto.Changeset{valid?: false}

      assert %Ecto.Changeset{valid?: false} =
               DateOverlap.validate_date_overlap(changeset, :starts_at, :ends_at)
    end
  end
end
