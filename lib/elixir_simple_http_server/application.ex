defmodule ElixirSimpleHttpServer.Application do

  # use Application
  import Supervisor.Spec

  def start(_type, _args) do
    children = [
      worker(Task, [ElixirSimpleHttpServer, :start, [50000]])
    ]

    opts = [strategy: :one_for_one, name: ElixirSimpleHttpServer.Supervisoer]
    Supervisor.start_link(children, opts)
  end
end