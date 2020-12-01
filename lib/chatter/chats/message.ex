defmodule Chatter.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatter.Chats.ChatNode

  schema "messages" do
    field :provider, :string
    field :provider_message_id, :string
    field :provider_sender_id, :string
    field :message_body, :string
    field :message_store, :map
    field :provider_recipient_id, :string
    belongs_to :chat_node, ChatNode

    timestamps()
  end

  def changeset(message, attrs) do
    arr = [:provider, :provider_message_id, :provider_sender_id, :message_body, :message_store, :provider_recipient_id]
    message
    |> cast(attrs, arr)
    |> validate_required(arr)
  end

end
