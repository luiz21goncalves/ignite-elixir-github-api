defmodule GithubApi.ErrorTest do
  use GithubApi.DataCase, async: true

  alias GithubApi.Error

  describe "build/2" do
    test "when all params are valid, returns a error struct" do
      response = Error.build(:bad_request, "Invalid password.")

      expected_response = %Error{
        status: :bad_request,
        reason: "Invalid password."
      }

      assert expected_response == response
    end
  end

  describe "build_user_not_found/0" do
    test "when called, returns an error for a user not found" do
      response = Error.build_user_not_found()

      expected_response = %Error{
        status: :not_found,
        reason: "User not found."
      }

      assert expected_response == response
    end
  end
end
