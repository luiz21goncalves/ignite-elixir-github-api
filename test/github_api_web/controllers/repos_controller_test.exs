defmodule GithubApiWeb.ReposControllerTest do
  use GithubApiWeb.ConnCase, async: true

  import Mox

  alias GithubApi.Github.ClientMock

  describe "show/2" do
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
        |> get(~p"/api/repos/diego3g")
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
  end
end
