defmodule GithubApi.UserTest do
  use GithubApi.DataCase, async: true

  import GithubApi.Factory

  alias Ecto.Changeset
  alias GithubApi.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)
      %{"name" => name, "email" => email, "password" => password} = params

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 name: ^name,
                 email: ^email,
                 password: ^password
               },
               valid?: true
             } = response
    end
  end
end
