defmodule ChatterWeb.Live.Chats.MessageComponent do
  use ChatterWeb, :live_component

  def render(assigns) do
    ~L"""
    <li class="customer-message" id=<% @message.id%>>
      <div class="user-id">
        <strong>
          <%= if @message.message_type == "customer" do %>
            Customer:
          <% else %>
            <%= @message.message_type %>
          <% end %>
          <%= @message.provider_customer_id %>
        </strong>
      </div>
      <div class="message-body">
        <small><%= @message.id %> | <%= @message.inserted_at %></small>
        <p class="lead">
          <%= raw @message.message_body %>
        </p>
      </div>
    </li>
    """
  end
end
