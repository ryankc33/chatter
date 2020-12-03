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
    arr = [:message_body]
    m = message
        |> cast(attrs, arr)
        |> validate_required(arr)
  end

  def form_user_message(message_body, chat_node) do
    %{
      provider: chat_node.provider,
      provider_message_id: "none",
      provider_customer_id: chat_node.provider_customer_id,
      provider_recipient_id: chat_node.provider_recipient_id,
      message_body: message_body,
      message_store: %{message_body: message_body},
      message_type: "user",
    }
  end
end
