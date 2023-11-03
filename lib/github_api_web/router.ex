defmodule GithubApiWeb.Router do
  use GithubApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubApiWeb do
    pipe_through :api

    get "/repos/:username", ReposController, :show

    post "/users", UsersController, :create

    post "/auth/login", SessionController, :create
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:github_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: GithubApiWeb.Telemetry
    end
  end
end
