ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GithubApi.Repo, :manual)

Mox.defmock(GithubApi.Github.ClientMock, for: GithubApi.Github.Behavior)
