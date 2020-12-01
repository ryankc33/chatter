defmodule ChatterWeb.Webhooks.V1.FacebookMessengerControllerTest do
  use ChatterWeb.ConnCase, async: true
  alias Chatter.ChatsFixtures
  alias Chatter.Repo
  alias Chatter.Chats.{ Message, ChatNode }

  describe "create" do
    test "POST with facebook params", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.webhooks_v1_facebook_messenger_path(conn, :create),
          ChatsFixtures.facebook_message_params_fixture()
        )

      assert text_response(conn, 200)
      assert Repo.aggregate(Message, :count, :id) == 1
      assert Repo.aggregate(ChatNode, :count, :id) == 1
    end
  end
end
