defmodule ChatterWeb.Live.Chats.MessageComponent do
  use ChatterWeb, :live_component

  def render(assigns) do
    ~L"""
    <%= if @message.message_type == "customer" do %>
      <li class="customer-message">
        <div class="user-id"><strong>User: <%= @message.provider_customer_id %></strong></div>
        <div class="message-body"><%= raw @message.message_body %></div>
      </li>
    <% else %>
      <li class="system-message">
        <div class="user-id"><strong><%= @message.message_type %></strong></div>
        <div class="message-body"><%= raw @message.message_body %></div>
      </li>
    <% end %>
    """
  end
end
