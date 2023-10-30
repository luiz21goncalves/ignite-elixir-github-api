defmodule GithubApi.Error do
  @keys [:status, :reason]

  defstruct @keys

  def build(status, reason) do
    %__MODULE__{
      status: status,
      reason: reason
    }
  end

  def build_user_not_found, do: build(:not_found, "User not found.")
end
