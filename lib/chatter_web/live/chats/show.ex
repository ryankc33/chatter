defmodule ChatterWeb.ChatsLive.Show do
  use ChatterWeb, :live_view
  alias Chatter.Chats
  alias Chatter.Chats.ChatNode
  import ChatterWeb.LiveHelpers

  @impl true
  def mount(%{"id" => id} = params, session, socket) do
    if connected?(socket), do: Chats.subscribe()

    chat = Chats.get_chat(params["id"])
    messages = chat.messages

    sock =
      socket
      |> authenticate_user(session)
      |> assign(chat: chat, messages: messages)
      |> assign(page_title: "Chat")

    {:ok, sock}
  end

  @impl true
  def handle_info({:message_created, message}, socket) do
    {:noreply, update(socket, :messages, fn messages -> [message | Enum.reverse(messages)] |> Enum.reverse end)}
  end
end
