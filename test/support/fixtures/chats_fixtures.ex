defmodule Chatter.ChatsFixtures do
  def message_fixture(attrs \\ %{}) do
    {:ok, message} = Chatter.Chats.create_message(attrs)
    message
  end

  def facebook_message_params_fixture() do
    %{
      "entry" => [
        %{
          "id" => "page_id",
          "messaging" => [
            %{
              "message" => %{
                "mid" => "message_id",
                "text" => "test"
              },
              "recipient" => %{"id" =>"page_id"},
              "sender" => %{"id" => "sender_id"},
              "timestamp" => 1606764062008
            }
          ],
          "time" => 1606764106659
        }
      ],
      "object" => "page"
    }
  end
end
