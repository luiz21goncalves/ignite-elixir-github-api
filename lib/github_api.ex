defmodule GithubApi do
  alias GithubApi.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
