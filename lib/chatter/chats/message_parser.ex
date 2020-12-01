defmodule Chatter.Chats.MessageParser do
  # %{
  #   "entry" => [
  #     %{
  #       "id" => <PAGE_ID>,
  #       "messaging" => [
  #         %{
  #           "message" => %{
  #             "mid" => string,
  #             "text" => "test"
  #           },
  #           "recipient" => %{"id" =><PAGE_ID>"},
  #           "sender" => %{"id" => <PSID>"},
  #           "timestamp" => 1606764062008
  #         }
  #       ],
  #       "time" => 1606764106659
  #     }
  #   ],
  #   "object" => "page"
  # }


  def parse_message(params) do
    entry = List.first(params["entry"])
    message = List.first(entry["messaging"])

    %{
      provider: "facebook",
      provider_message_id: message["message"]["mid"],
      provider_sender_id: message["sender"]["id"],
      provider_recipient_id: message["recipient"]["id"],
      message_body: message["message"]["text"],
      message_store: params,
    }
  end
  def parse_message(%{}), do: %{}
end
