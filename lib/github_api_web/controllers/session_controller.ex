defmodule GithubApiWeb.SessionController do
  use GithubApiWeb, :controller

  alias GithubApiWeb.Auth.Guardian
  alias GithubApiWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> json(%{token: token})
    end
  end
end
