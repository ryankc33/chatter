defmodule Chatter.Chats do
  alias Ecto
  import Ecto.Query
  alias Chatter.Repo
  alias Chatter.Chats.{ Message, ChatNode, MessageParser }

  def list_chats do
    ChatNode
    |> Repo.all()
  end

  def get_chat(id) do
    ChatNode
    |> Repo.get(id)
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
  end

  defp first_or_create_chat_node(attrs) do
    query = from c in ChatNode, where: c.provider == ^attrs.provider, where: c.provider_sender_id == ^attrs.provider_sender_id, limit: 1

    chat_node =
      case Repo.one(query) do
        nil ->
          {:ok, new_record} =
            create_chat_node(%{
              uuid: Ecto.UUID.generate,
              provider: "facebook",
              provider_sender_id: attrs.provider_sender_id,
              provider_recipient_id: attrs.provider_recipient_id
            })
          new_record
        ok -> ok
      end
  end
end
