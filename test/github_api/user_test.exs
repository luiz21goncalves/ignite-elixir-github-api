defmodule GithubApi.UserTest do
  use GithubApi.DataCase, async: true

  alias Ecto.Changeset
  alias GithubApi.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        "name" => "John Doe",
        "email" => "john.doe@email.com",
        "password" => "strong-password"
      }

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 name: "John Doe",
                 email: "john.doe@email.com",
                 password: "strong-password"
               },
               valid?: true
             } = response
    end
  end
end
