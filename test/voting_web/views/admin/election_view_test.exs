defmodule VotingWeb.Admin.ElectionViewTest do
  use ExUnit.Case, async: true

  alias VotingWeb.Admin.ElectionView

  import Voting.Factory

  describe "render/2 session.json" do
    test "returns ok and the admin data" do
      election = build(:election, id: 1)

      assert %{
               status: :ok,
               data: %{
                 name: "Election 2020",
                 cover: "http-to-an-image",
                 notice: "http-to-a-pdf",
                 starts_at: ~U[2020-02-01 11:00:00Z],
                 ends_at: ~U[2020-02-29 11:00:00Z],
               }
             } = ElectionView.render("election.json", %{election: election})
    end
  end
end
