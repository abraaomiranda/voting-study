defmodule Voting.ElectionRepo do
  @moduledoc """
  Election repository
  """

  alias Voting.{Election, Repo}

  def get_election!(id) do
    Repo.get!(Election, id)
  end
end
