defmodule GithubApiWeb.FallbackController do
  use GithubApiWeb, :controller

  alias GithubApi.Error
  alias GithubApiWeb.ErrorJSON

  def call(conn, {:error, %Error{status: status, reason: reason}}) do
    conn
    |> put_status(status)
    |> put_view(json: ErrorJSON)
    |> render("error.json", reason: reason)
  end
end
