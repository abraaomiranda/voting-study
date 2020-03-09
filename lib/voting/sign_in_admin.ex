defmodule Voting.SignInAdmin do
  @moduledoc """
  Singing in as admin
  """

  alias Voting.{Admin, Repo}

  def run(email, password) do
    case Repo.get_by(Admin, email: email) do
      %Admin{} = admin -> verify_password(admin, password)
      nil -> {:error, :invalid_email_or_password}
    end
  end

  defp verify_password(admin, password) do
    if Bcrypt.verify_pass(password, admin.password_hash) do
      {:ok, admin}
    else
      {:error, :invalid_email_or_password}
    end
  end
end
