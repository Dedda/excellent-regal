defmodule RegalWeb.Router do
  use RegalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RegalWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/credits", PageController, :credits
    resources "/galleries", GalleryController
    resources "/pictures", PictureController
    get "/pictures/raw/:id", PictureController, :raw
    get "/thumb/:id", PictureController, :thumb
    resources "/gallery_pictures", GalleryPictureController
    resources "/tags", TagController
    resources "/picture_tags", PictureTagController
    get "/config", ConfigController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RegalWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RegalWeb.Telemetry, ecto_repos: [Regal.Repo]
    end
  end
end
