defmodule ChatterWeb.Webhooks.V1.FacebookMessengerController do
  use ChatterWeb, :controller
  alias Chatter.Chats

  def index(conn, %{"hub.challenge" => challenge, "hub.mode" => mode, "hub.verify_token" => verify_token} = params) do
    if is_valid_challenge(mode, verify_token, challenge) do
      conn
      |> put_status(200)
      |> text(challenge)
    else
      conn
      |> put_status(200)
      |> text("OK")
    end
  end

  def create(conn, params) do
    IO.inspect conn

    Chats.create_message(params)

    conn
    |> put_status(200)
    |> text("OK")
  end

  defp is_valid_challenge("subscribe", token, challenge) when is_binary(challenge) and is_binary(token) do
    System.get_env("FACEBOOK_MESSENGER_VERIFY_TOKEN") == token
  end

  defp is_valid_challenge(_, _, _), do: false
end
