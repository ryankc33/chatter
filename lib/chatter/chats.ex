defmodule Chatter.Chats do
  alias Ecto
  import Ecto.Query
  alias Chatter.Repo
  alias Chatter.Chats.{ Message, ChatNode, MessageParser, MessageResponder }

  def list_chats do
    ChatNode
    |> Repo.all()
  end

  def get_chat(id) do
    message_query = from(m in Message, order_by: [asc: m.id])

    query = from chat in ChatNode,
           where: chat.id == ^id,
           preload: [
              messages: ^message_query
           ]

    Repo.one(query)
  end

  def create_chat_node(attrs \\ %{}) do
    %ChatNode{}
    |> ChatNode.changeset(attrs)
    |> Repo.insert()
  end

  def create_message(params \\ %{}) do
    attrs = MessageParser.parse_message(params)
    chat_node = first_or_create_chat_node(attrs)

    %Message{}
    |> Message.changeset(attrs)
    |> Ecto.Changeset.put_change(:chat_node_id, chat_node.id)
    |> Repo.insert()
    |> broadcast(:message_created)
  end

  def create_auto_response(string, old_message) do
    attrs = MessageParser.parse_auto_response(string, old_message)
    chat_node = first_or_create_chat_node(attrs)

    %Message{}
    |> Message.changeset(attrs)
    |> Ecto.Changeset.put_change(:chat_node_id, chat_node.id)
    |> Repo.insert()
    |> broadcast(:message_created)
  end

  def create_user_message(%{"message_body" => message}, chat_node) do
    attrs = Message.form_user_message(message, chat_node)

    %Message{}
    |> Message.changeset(attrs)
    |> Ecto.Changeset.put_change(:chat_node_id, chat_node.id)
    |> Repo.insert()
    |> broadcast(:message_created)
  end

  def change_user_message(%Message{} = message, attrs \\ %{}) do
    Message.user_changeset(message, attrs)
  end

  defp first_or_create_chat_node(attrs) do
    query = from c in ChatNode, where: c.provider == ^attrs.provider, where: c.provider_customer_id == ^attrs.provider_customer_id, limit: 1

    chat_node =
      case Repo.one(query) do
        nil ->
          {:ok, new_record} =
            create_chat_node(%{
              uuid: Ecto.UUID.generate,
              provider: "facebook",
              provider_customer_id: attrs.provider_customer_id,
              provider_recipient_id: attrs.provider_recipient_id
            })
          new_record
        ok -> ok
      end
  end

  def auto_respond(message) do
    Task.Supervisor.start_child(
      __MODULE__, MessageResponder, :auto_respond, [message], restart: :transient
    )
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Chatter.PubSub, "messages")
  end

  defp broadcast({:error, _reason} = error, _event), do: error
  defp broadcast({:ok, message}, event) do
    IO.inspect message, label: "handled"

    Phoenix.PubSub.broadcast(Chatter.PubSub, "messages", {event, message})
    {:ok, message}
  end
end
