defmodule Chatter.Repo.Migrations.CreateChatNodesTable do
  use Ecto.Migration

  def change do
    create table(:chat_nodes) do
      add :uuid, :string, null: false
      add :provider, :string, null: false
      add :provider_sender_id, :string, null: false
      add :provider_recipient_id, :string, null: false

      timestamps()
    end

    create index(:chat_nodes, [:uuid])
    create index(:chat_nodes, [:provider, :provider_sender_id])
  end
end
