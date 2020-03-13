defmodule Voting.SignInAdminTest do
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.{Admin, SignInAdmin}

  describe "run/2" do
    setup do
      insert(:admin)
      :ok
    end

    test "returns ok when email and password matches" do
      assert {:ok, %Admin{}} = SignInAdmin.run("email@example.com", "123456")
    end

    test "returns error when there is no admin with email" do
      assert {:error, :invalid_email_or_password} = SignInAdmin.run("email@example", "123456")
    end

    test "returns error when password is invalid" do
      assert {:error, :invalid_email_or_password} = SignInAdmin.run("email@example.com", "12345")
    end
  end
end
