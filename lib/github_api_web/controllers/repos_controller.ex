defmodule GithubApiWeb.ReposController do
  use GithubApiWeb, :controller

  def show(conn, %{"username" => username}) do
    conn
    |> put_status(:ok)
    |> json(%{username: username})
  end
end
