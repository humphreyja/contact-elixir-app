defmodule Contact.App.UserController do
  use Contact.Web, :controller

  alias Contact.Repo
  alias Contact.User
  alias Contact.Authorization

  plug :put_layout, "action-overlay.html"


  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__, typ: "token"

  def edit(conn, params, current_user, _claims) do
    IO.puts current_user.id
    user = Repo.get!(User, current_user.id) |> Repo.preload([:authorizations])
    render conn, "edit.html", current_user: user
  end

  # The unauthenticated function is called because this controller has been
  # specified as the handler.
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: auth_path(conn, :login, :identity))
  end
end
