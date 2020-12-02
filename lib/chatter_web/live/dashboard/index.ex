defmodule ChatterWeb.DashboardLive.Index do
  use ChatterWeb, :live_view
  alias Chatter.Chats
  alias Chatter.Chats.ChatNode
  import ChatterWeb.LiveHelpers

  @impl true
  def mount(_params, session, socket) do
    sock =
      socket
      |> authenticate_user(session)
      |> assign(page_title: "Dashboard")
      |> assign(chat_nodes: list_chats())

    {:ok, sock}
  end

  defp list_chats, do: Chats.list_chats()
end
