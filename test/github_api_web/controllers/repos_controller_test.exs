defmodule GithubApiWeb.ReposControllerTest do
  use GithubApiWeb.ConnCase, async: true

  import Mox
  import GithubApi.Factory

  alias GithubApi.Github.ClientMock
  alias GithubApiWeb.Auth.Guardian

  describe "show/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _clams} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn}
    end

    test "when all params are valid, returns the repos", %{conn: conn} do
      expect(ClientMock, :get_user_repos, fn _repos ->
        {:ok,
         [
           %{
             "id" => 544_892_371,
             "name" => "05-design-system",
             "description" => "Design system construído no Ignite",
             "html_url" => "https://github.com/diego3g/05-design-system",
             "stargazers_count" => 36
           },
           %{
             "id" => 639_913_817,
             "name" => "ai-tools",
             "description" => "ai-tools",
             "html_url" => "https://github.com/diego3g/ai-tools",
             "stargazers_count" => 125
           }
         ]}
      end)

      response =
        conn
        |> get(Routes.repos_path(conn, :show, "diego3g"))
        |> json_response(:ok)

      assert %{
               "repos" => [
                 %{
                   "id" => 544_892_371,
                   "name" => "05-design-system",
                   "description" => "Design system construído no Ignite",
                   "html_url" => "https://github.com/diego3g/05-design-system",
                   "stargazers_count" => 36
                 },
                 %{
                   "id" => 639_913_817,
                   "name" => "ai-tools",
                   "description" => "ai-tools",
                   "html_url" => "https://github.com/diego3g/ai-tools",
                   "stargazers_count" => 125
                 }
               ]
             } = response
    end

    test "when is not authenticated, returns an error" do
      conn = build_conn()

      response =
        conn
        |> get(Routes.repos_path(conn, :show, "diego3g"))

      expected_response = Jason.encode!(%{message: "unauthenticated"})

      assert %{status: 401, resp_body: body} = response
      assert expected_response == body
    end
  end
end
