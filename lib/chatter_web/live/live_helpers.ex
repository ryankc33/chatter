defmodule ChatterWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers
  alias Chatter.Accounts

  def authenticate_user(socket, %{"user_token" => user_token} = session) do
    if user_token do
      assign_new(socket, :current_user,  fn -> Accounts.get_user_by_session_token(user_token) end)
    else
      redirect(socket, to: "/users/log_in")
    end
  end

  @doc """
  Renders a component inside the `ChatterWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, ChatterWeb.ModalComponent, modal_opts)
  end
end
