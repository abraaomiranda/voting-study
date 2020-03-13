defmodule Voting.FakeFile do
  @moduledoc false

  def start("/users/local/images/large_logo.jpg") do
    {:ok, %{size: 6_000_000}}
  end

  def start(_file_path) do
    {:ok, %{size: 1_000_000}}
  end
end
