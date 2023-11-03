defmodule GithubApiWeb.SessionControllerTest do
  use GithubApiWeb.ConnCase, async: true

  import GithubApi.Factory

  alias GithubApi.User

  describe "create/2" do
    test "when all params are valid, generate jwt token", %{conn: conn} do
      {:ok, %User{email: email, password: password}} = GithubApi.create_user(build(:user_params))
      params = %{"email" => email, "password" => password}

      response =
        conn
        |> post(Routes.session_path(conn, :create, params))
        |> json_response(:ok)

      assert %{"token" => _} = response
    end

    test "when all params are invalid, returns an error", %{conn: conn} do
      params = %{}

      response =
        conn
        |> post(Routes.session_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid or missing params"}

      assert expected_response == response
    end

    test "when the password is wrong, returns an error", %{conn: conn} do
      {:ok, %User{email: email}} = GithubApi.create_user(build(:user_params))
      params = %{"email" => email, "password" => "wrong-password"}

      response =
        conn
        |> post(Routes.session_path(conn, :create, params))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Please verify your credentials."}

      assert expected_response == response
    end

    test "when the email is wrong, returns an error", %{conn: conn} do
      {:ok, %User{password: password}} = GithubApi.create_user(build(:user_params))
      params = %{"email" => "wrong@email.com", "password" => password}

      response =
        conn
        |> post(Routes.session_path(conn, :create, params))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Please verify your credentials."}

      assert expected_response == response
    end
  end
end
