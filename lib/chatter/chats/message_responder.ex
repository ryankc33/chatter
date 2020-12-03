defmodule Chatter.Chats.MessageResponder do
  alias Chatter.Chats
  alias Chatter.Chats.Robot
  alias Chatter.Chats.Responders.FacebookClient

  def auto_respond(message) do
    message
    |> Robot.form_response_body
    |> Chats.create_auto_response(message)
    |> send_response(message.provider)
  end

  def user_response({_, message}) do
    send_response({:ok, message}, message.provider)
  end

  defp send_response({_, new_message}, "facebook"), do: FacebookClient.call(new_message)
  defp send_response(_, _), do: {:error, "No Client found"}
end
