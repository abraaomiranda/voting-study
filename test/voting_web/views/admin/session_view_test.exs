defmodule VotingWeb.Admin.SessionViewTest do
  use ExUnit.Case, async: true

  alias VotingWeb.Admin.SessionView

  import Voting.Factory

  describe "render/2 session.json" do
    test "returns ok and the admin data" do
      admin = params_for(:admin)

      assert %{status: :ok, data: %{name: "Jane Smith"}} =
               SessionView.render("session.json", %{admin: admin})
    end
  end
end
