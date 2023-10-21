defmodule GithubApi.Github.Behavior do
  @callback get_user_repos(String.t()) :: {:ok, map()} | {:error, map()}
end
