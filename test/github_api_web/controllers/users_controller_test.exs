defmodule GithubApiWeb.UsersControllerTest do
  use GithubApiWeb.ConnCase, async: true

  import GithubApi.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)
      %{"name" => name, "email" => email} = params

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "user" => %{
                 "id" => _id,
                 "name" => ^name,
                 "email" => ^email,
                 "inserted_at" => _inserted_at,
                 "updated_at" => _updated_at
               }
             } = response
    end

    test "when there is some error, returns an error", %{conn: conn} do
      params = build(:user_params, %{"password" => "123", "name" => nil, "email" => nil})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "email" => ["can't be blank"],
          "name" => ["can't be blank"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected_response
    end
  end
end
