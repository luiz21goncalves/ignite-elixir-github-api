defmodule GithubApiWeb.ErrorJSON do
  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def render("error.json", %{reason: %Changeset{} = changeset}) do
    %{message: translate_errors(changeset)}
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts
        |> Keyword.get(String.to_existing_atom(key), key)
        |> to_string()
      end)
    end)
  end
end
