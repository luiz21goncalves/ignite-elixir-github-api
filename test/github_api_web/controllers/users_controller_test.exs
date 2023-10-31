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
  end
end
