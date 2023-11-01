defmodule GithubApi do
  alias GithubApi.Users.Create, as: UserCreate
  alias GithubApi.Users.Get, as: UserGet

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate get_user_by_email(email), to: UserGet, as: :by_email
end
