defmodule ChatterWeb.PageController do
  use ChatterWeb, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      redirect(conn, to: Routes.dashboard_index_path(conn, :index))
    else
      render(conn, "index.html")
    end
  end
end
