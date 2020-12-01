defmodule Chatter.Repo.Migrations.AddChatNodeIdToMessages do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :chat_node_id, references(:chat_nodes, on_delete: :delete_all)
    end
  end
end
