defmodule ChatterWeb.Live.Chats.MessageFormComponent do
  use ChatterWeb, :live_component

  alias Chatter.Chats

  @impl true
  def handle_event("validate", %{"message" => message_params}, socket) do
    changeset =
      socket.assigns.changeset
      |> Chats.change_user_message(message_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"message"=> message_params}, socket) do
    case Chats.create_message(message_params) do
      {:ok, _message} -> {:noreply, socket |> put_flash(:info, "Message saved") }
      {:error, %Ecto.Changeset{} = changeset} -> {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
