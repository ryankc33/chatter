defmodule Chatter.Chats.Responders.FacebookClient do
  alias Jason

  def call(message) do
    message
    |> as_facebook_response
    |> Jason.encode
    |> post
  end

  defp post({_, data}) do
    Tesla.post(
      "https://graph.facebook.com/v9.0/me/messages?access_token=" <> System.get_env("FACEBOOK_PAGE_ACCESS_TOKEN"),
      data,
      headers: [{"content-type", "application/json"}]
    )
  end

  defp as_facebook_response(message) do
    %{
        messaging_type: "RESPONSE",
        recipient: %{
          id: message.provider_customer_id
        },
        message: %{
          text: message.message_body
        }
      }
  end
end
