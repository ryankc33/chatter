defmodule FacebookResponder do
  alias Jason

  def send_message(message) do
    {:ok, data} = body(message) |> Jason.encode

    {:ok, response} = post(data)
    response
  end

  defp post(data) do
    Tesla.post(
      "https://graph.facebook.com/v9.0/me/messages?access_token=" <> System.get_env("FACEBOOK_PAGE_ACCESS_TOKEN"),
      data,
      headers: [{"content-type", "application/json"}]
    )
  end

  defp body(message) do
    %{
        messaging_type: "RESPONSE",
        recipient: %{
          id: message.provider_sender_id
        },
        message: %{
          text: "hello"
        }
      }
  end
end
