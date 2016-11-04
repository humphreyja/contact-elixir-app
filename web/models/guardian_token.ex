defmodule Contact.GuardianToken do
  use Contact.Web, :model

  alias Contact.Repo
  alias Contact.GuardianSerializer

  @primary_key {:jti, :string, []}
  @derive {Phoenix.Param, key: :jti}
  schema "guardian_tokens" do
    field :aud, :string
    field :iss, :string
    field :sub, :string
    field :exp, :integer
    field :jwt, :string
    field :claims, :map

    timestamps
  end

  def for_user(user) do
    IO.puts "for user"
    case GuardianSerializer.for_token(user) do
      {:ok, aud} ->
        (from t in Contact.GuardianToken, where: t.sub == ^aud)
          |> Repo.all
      _ -> []
    end
  end
end
