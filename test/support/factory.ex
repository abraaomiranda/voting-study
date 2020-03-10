defmodule Voting.Factory do
  @moduledoc """
  Factory
  """
  use ExMachina.Ecto, repo: Voting.Repo

  def admin_factory do
    %Voting.Admin{
      name: "Jane Smith",
      email: "email@example.com",
      password_hash: Bcrypt.hash_pwd_salt("123456")
    }
  end

  def election_factory do
    %Voting.Election{
      name: "Election 2020",
      cover: "http-to-an-image",
      notice: "http-to-a-pdf",
      starts_at: ~U[2020-02-01 11:00:00Z],
      ends_at: ~U[2020-02-29 11:00:00Z],
      created_by: build(:admin)
    }
  end
end
