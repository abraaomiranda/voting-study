defmodule VotingWeb.AuthAccessPipeline do
  @moduledoc """
  Pipeline to authenticate logged user
  """

  use Guardian.Plug.Pipeline, otp_app: :voting

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
