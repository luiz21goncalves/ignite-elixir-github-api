defmodule GithubApi.Factory do
  alias GithubApi.User
  use ExMachina.Ecto, repo: GithubApi.Repo

  def user_params_factory do
    %{
      "name" => Faker.Person.name(),
      "email" => Faker.Internet.email(),
      "password" => Faker.String.base64()
    }
  end

  def user_factory do
    %User{
      name: Faker.Person.name(),
      email: Faker.Internet.email(),
      password: Faker.String.base64()
    }
  end
end
