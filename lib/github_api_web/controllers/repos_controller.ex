defmodule GithubApiWeb.ReposController do
  use GithubApiWeb, :controller

  alias GithubApiWeb.FallbackController

  action_fallback FallbackController

  def show(conn, %{"username" => username}) do
    with {:ok, raw_repos} <- client().get_user_repos(username),
         repos <- format_repos(raw_repos) do
      conn
      |> put_status(:ok)
      |> json(%{repos: repos})
    end
  end

  defp format_repos(repos) do
    Enum.map(repos, fn %{
                         "id" => id,
                         "name" => name,
                         "description" => description,
                         "html_url" => html_url,
                         "stargazers_count" => stargazers_count
                       } ->
      %{
        id: id,
        name: name,
        description: description,
        html_url: html_url,
        stargazers_count: stargazers_count
      }
    end)
  end

  defp client do
    :github_api
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_client_adapter)
  end
end
