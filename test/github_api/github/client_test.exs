defmodule GithubApi.Github.ClientTest do
  use ExUnit.Case, async: true

  alias GithubApi.Github.Client
  alias Plug.Conn

  describe "get_user_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid username, returns the repos", %{bypass: bypass} do
      username = "diego3g"

      url = endpoint_url(bypass.port)

      body = ~s([
        {
          "id": 544892371,
          "name": "05-design-system",
          "description": "Design system construído no Ignite",
          "html_url": "https://github.com/diego3g/05-design-system",
          "stargazers_count": 36
        },
        {
          "id": 639913817,
          "name": "ai-tools",
          "description": "ai-tools",
          "html_url": "https://github.com/diego3g/ai-tools",
          "stargazers_count": 125
        }
      ])

      Bypass.expect_once(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      response = Client.get_user_repos(url, username)

      expected_response =
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

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
