defmodule Chatter.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatter.Chats.ChatNode

  schema "messages" do
    field :provider, :string
    field :provider_message_id, :string
    field :provider_customer_id, :string
    field :provider_recipient_id, :string
    field :message_body, :string
    field :message_store, :map
    field :message_type, :string
    belongs_to :chat_node, ChatNode

    timestamps()
  end

  def changeset(message, attrs) do
    arr = [:provider, :provider_message_id, :provider_customer_id, :message_body, :message_store, :provider_recipient_id, :message_type]
    message
    |> cast(attrs, arr)
    |> validate_required(arr)
  end

  def user_changeset(message, attrs) do
    IO.inspect message, label: "message"
    IO.inspect attrs, label: "attrs"

    arr = [:message_body]
    m = message
        |> cast(attrs, arr)
        |> validate_required(arr)
    IO.inspect m, label: "message after"
  end
end
