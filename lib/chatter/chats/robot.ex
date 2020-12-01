defmodule Chatter.Chats.Robot do
  alias Chatter.Chats.MessageParser
  alias Chatter.Chats.Robots.Diamond

  def form_response_body(message) do
    body = String.downcase(message.message_body)

    cond do
      is_a_ping(body) -> "Pong!"
      wants_a_diamond(body) -> Diamond.call(body)
      do_we_know(body) -> "I'll find out for you!"
      is_a_greeting(body) -> randomized_greeting()
      true -> body
    end
  end

  defp is_a_ping(body), do: String.contains?(body, "ping!")
  defp do_we_know(body), do: String.contains?(body, "do") && String.contains?(body, "know")
  defp wants_a_diamond(body), do: String.contains?(body, "diamond")

  @greetings ["hello", "hey", "hi", "bonjour", "guten tag", "你好"]
  defp is_a_greeting(body), do: body in @greetings
  defp randomized_greeting(), do: Enum.at(@greetings, :rand.uniform(5)) <> "!"
end
