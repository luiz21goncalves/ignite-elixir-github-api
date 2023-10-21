defmodule GithubApi.Github.Client do
  use Tesla

  alias GithubApi.Github.Behavior
  alias Tesla.Env

  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  @behaviour Behavior

  @base_url "https://api.github.com/users/"

  def get_user_repos(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:error, reason}) do
    {:error, reason}
  end
end
