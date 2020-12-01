defmodule Chatter.Repo.Migrations.CreateMessagesTable do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :provider, :string, null: false
      add :provider_message_id, :string, null: false
      add :provider_sender_id, :string, null: false
      add :message_body, :text, null: false
      add :message_store, :map, default: %{}
      add :provider_recipient_id, :string
      timestamps()
    end

    create index(:messages, [:provider])
  end
end
