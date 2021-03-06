defmodule ChatterWeb.Router do
  use ChatterWeb, :router

  import ChatterWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :put_root_layout, {ChatterWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :webhooks do
    plug :accepts, ["json"]
  end

  scope "/", ChatterWeb do
    pipe_through :browser

    get "/", LandingController, :index

    delete "/users/log_out", UserSessionController, :delete
    # get "/users/confirm", UserConfirmationController, :new
    # post "/users/confirm", UserConfirmationController, :create
    # get "/users/confirm/:token", UserConfirmationController, :confirm
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatterWeb do
  #   pipe_through :api
  # end

  ## Authentication routes

  scope "/", ChatterWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    # get "/users/register", UserRegistrationController, :new
    # post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    # get "/users/reset_password", UserResetPasswordController, :new
    # post "/users/reset_password", UserResetPasswordController, :create
    # get "/users/reset_password/:token", UserResetPasswordController, :edit
    # put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", ChatterWeb do
    pipe_through [:browser, :require_authenticated_user]

    # get "/users/settings", UserSettingsController, :edit
    # put "/users/settings/update_password", UserSettingsController, :update_password
    # put "/users/settings/update_email", UserSettingsController, :update_email
    # get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    live "/dashboard", DashboardLive.Index, :index
    live "/chats/:id", ChatsLive.Show, :show
  end

  scope "/webhooks", ChatterWeb.Webhooks, as: :webhooks do
    pipe_through :webhooks

    scope "/v1", V1, as: :v1 do
      resources "/facebook_messenger", FacebookMessengerController, only: [:index, :create]
    end
  end
end
