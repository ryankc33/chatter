defmodule Chatter.ChatsTest do
  use Chatter.DataCase
  alias Chatter.Chats
  import Chatter.ChatsFixtures

  describe "create_message" do
    test "it saves a message" do
      {:ok, message} = Chats.create_message(facebook_message_params_fixture())
      assert is_integer message.chat_node_id
    end
  end
end
