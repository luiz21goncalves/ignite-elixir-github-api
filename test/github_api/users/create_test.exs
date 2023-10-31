defmodule GithubApi.Users.CreateTest do
  use GithubApi.DataCase, async: true

  import GithubApi.Factory

  alias GithubApi.Error
  alias GithubApi.User

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)
      %{"name" => name, "email" => email, "password" => password} = params

      response = GithubApi.create_user(params)

      assert {:ok,
              %User{
                name: ^name,
                email: ^email,
                password: ^password,
                password_hash: _password_hash,
                id: _id,
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when all params are invalid, returns an error" do
      params =
        build(:user_params, %{"email" => "invalid email", "name" => nil, "password" => "123"})

      response = GithubApi.create_user(params)

      expected_response = %{
        name: ["can't be blank"],
        password: ["should be at least 6 character(s)"],
        email: ["has invalid format"]
      }

      assert {:error, %Error{status: :bad_request, reason: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
