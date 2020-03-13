defmodule Voting.DateOverlap do
  @moduledoc """
  Validate if dates overlapping
  """

  import Ecto.Changeset, only: [get_field: 2, add_error: 3]

  def validate_date_overlap(%Ecto.Changeset{valid?: true} = changeset, first_date_field, second_date_field) do
    first_date = get_field(changeset, first_date_field)
    second_date = get_field(changeset, second_date_field)

    if DateTime.compare(first_date, second_date) == :gt do
      add_error(changeset, first_date_field, "should be before #{second_date_field}")
    else
      changeset
    end
  end

  def validate_date_overlap(%Ecto.Changeset{} = changeset, _, _), do: changeset
end
