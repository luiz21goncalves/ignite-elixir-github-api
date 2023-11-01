defmodule GithubApiWeb.Auth.Guardian do
  use Guardian, otp_app: :github_api

  alias GithubApi.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}) do
    GithubApi.get_user_by_id(id)
  end
end
