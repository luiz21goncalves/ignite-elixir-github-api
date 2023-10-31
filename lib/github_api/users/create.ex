defmodule GithubApi.Users.Create do
  alias GithubApi.Error
  alias GithubApi.Repo
  alias GithubApi.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
