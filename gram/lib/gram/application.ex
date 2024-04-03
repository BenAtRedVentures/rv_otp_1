defmodule Gram.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Gram.Server

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Gram.Worker.start_link(arg)
      {Server, :spider_man},
      {Server, :thor},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gram.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
