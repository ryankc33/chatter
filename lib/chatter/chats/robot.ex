defmodule Chatter.Chats.Robot do
  alias Chatter.Chats.MessageParser
  alias Chatter.Chats.Robots.Diamond

  def form_response_body(message) do
    body = String.downcase(message.message_body)

    cond do
      is_a_ping(body) -> "Pong!"
      wants_a_diamond(body) -> Diamond.call(body)
      is_a_question(body) -> "I don't know, but I'll find out and let you know!"
      is_a_greeting(body) -> randomized_greeting()
      true -> body
    end
  end

  defp is_a_ping(body), do: String.contains?(body, "ping!")

  @questions ["who", "what", "where", "when", "why", "how"]
  defp is_a_question(body), do: String.contains?(body, @questions)
  defp wants_a_diamond(body), do: String.contains?(body, "diamond")

  @greetings ["hello", "hey", "hi", "bonjour", "guten tag", "你好"]
  defp is_a_greeting(body), do: String.contains?(body, @greetings)
  defp randomized_greeting(), do: Enum.at(@greetings, :rand.uniform(5)) <> "!"
end
