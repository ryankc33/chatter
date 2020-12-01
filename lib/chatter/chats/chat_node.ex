defmodule Chatter.Chats.ChatNode do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatter.Chats.Message

  schema "chat_nodes" do
    field :uuid, :string
    field :provider, :string
    field :provider_sender_id, :string
    field :provider_recipient_id, :string
    has_many :messages, Message

    timestamps()
  end

  def changeset(chat_node, attrs) do
    arr = [:uuid, :provider, :provider_sender_id, :provider_recipient_id]

    chat_node
    |> cast(attrs, arr)
    |> validate_required(arr)
  end
end
