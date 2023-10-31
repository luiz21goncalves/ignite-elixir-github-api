defmodule GithubApiWeb.UsersController do
  use GithubApiWeb, :controller

  alias GithubApi.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- GithubApi.create_user(params) do
      conn
      |> put_status(:created)
      |> json(%{user: user})
    end
  end
end
