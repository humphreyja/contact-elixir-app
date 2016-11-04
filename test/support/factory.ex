defmodule Contact.Factory do
  use ExMachina.Ecto, repo: Contact.Repo

  alias Contact.User
  alias Contact.Authorization
  alias Contact.GuardianToken

  def factory(:user) do
    %User{
      name: "Bob Belcher",
      email: sequence(:email, &"email-#{&1}@example.com"),
    }
  end

  def factory(:guardian_token) do
    %GuardianToken{
      jti: sequence(:jti, &"jti-#{&1}"),
    }
  end

  def factory(:authorization) do
    %Authorization{
      uid: sequence(:uid, &"uid-#{&1}"),
      user: build(:user),
      provider: "identity",
      token: Comeonin.Bcrypt.hashpwsalt("sekrit")
    }
  end

  def with_authorization(user, opts \\ []) do
    opts = opts ++ [user: user, uid: user.email]
    create(:authorization, opts)
  end
end
