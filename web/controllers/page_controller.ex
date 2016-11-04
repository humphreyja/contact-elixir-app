defmodule Contact.PageController do
  use Contact.Web, :controller
  alias Contact.Repo


  def index(conn, _params, current_user, _claims) do
    render conn, "index.html", current_user: current_user
  end
end
