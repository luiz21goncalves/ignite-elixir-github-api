defmodule GithubApi.Users.GetTest do
  use GithubApi.DataCase, async: true

  import GithubApi.Factory

  alias GithubApi.Error

  describe "by_id/1" do
    test "when the user was found" do
      user = insert(:user)

      response = GithubApi.get_user_by_id(user.id)

      expected_response = {:ok, %{user | password: nil}}

      assert expected_response == response
    end

    test "when the user was not found" do
      id = Ecto.UUID.generate()

      response = GithubApi.get_user_by_id(id)

      expected_response = {:error, %Error{status: :not_found, reason: "User not found."}}

      assert expected_response == response
    end
  end

  describe "by_email/1" do
    test "when the user was found" do
      user = insert(:user)

      response = GithubApi.get_user_by_email(user.email)

      expected_response = {:ok, %{user | password: nil}}

      assert expected_response == response
    end

    test "when the user was not found" do
      email = Faker.Internet.email()

      response = GithubApi.get_user_by_email(email)

      expected_response = {:error, %Error{status: :not_found, reason: "User not found."}}

      assert expected_response == response
    end
  end
end
