defmodule Contact.UserController do
  use Contact.Web, :controller

  alias Contact.Repo
  alias Contact.User
  alias Contact.Authorization

  def new(conn, params, current_user, _claims) do
    render conn, "new.html", current_user: current_user
  end
end
