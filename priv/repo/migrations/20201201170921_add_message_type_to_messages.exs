defmodule Chatter.Repo.Migrations.AddMessageTypeToMessages do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :message_type, :string, null: false, default: "customer"
    end

    drop index(:chat_nodes, [:provider, :provider_sender_id])
    rename table(:chat_nodes), :provider_sender_id, to: :provider_customer_id
    create index(:chat_nodes, [:provider, :provider_customer_id])

    rename table(:messages), :provider_sender_id, to: :provider_customer_id
    create index(:messages, [:message_type])
  end
end
