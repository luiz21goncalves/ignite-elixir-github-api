defmodule GithubApiWeb.ReposController do
  alias GithubApi.Github.Client
  use GithubApiWeb, :controller

  def show(conn, %{"username" => username}) do
    with {:ok, raw_repos} <- Client.get_user_repos(username),
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
end
