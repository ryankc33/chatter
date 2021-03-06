defmodule ChatterWeb.Live.Chats.MessageFormComponent do
  use ChatterWeb, :live_component

  alias Chatter.Chats
  alias Chatter.Chats.Message

  @impl true
  def handle_event("validate", %{"message" => message_params}, socket) do
    message_changeset =
      socket.assigns.message
      |> Chats.change_user_message(message_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, message_changeset)}
  end

  def handle_event("save", %{"message"=> message_params}, socket) do
    case Chats.create_user_message(message_params, socket.assigns.chat_node) do
      {:ok, _message} -> {
                          :noreply,
                          socket
                          |> put_flash(:info, "Message saved")
                          |> assign(changeset: Chats.change_user_message(%Message{}))
                        }
      {:error, %Ecto.Changeset{} = changeset} -> {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
