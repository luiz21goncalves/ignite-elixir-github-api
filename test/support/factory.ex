defmodule GithubApi.Factory do
  use ExMachina.Ecto, repo: GithubApi.Repo

  def user_params_factory do
    %{
      "name" => Faker.Person.name(),
      "email" => Faker.Internet.email(),
      "password" => Faker.String.base64()
    }
  end
end
