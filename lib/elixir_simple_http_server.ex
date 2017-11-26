defmodule ElixirSimpleHttpServer do

  def start(port \\ 80) do
    {:ok, lsocket} = :gen_tcp.listen(port,  [:binary, packet: :line, active: false, reuseaddr: true])
    loop_acceptor(lsocket)
  end

  def loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    serve(client)
    loop_acceptor(socket)
  end

  def serve(socket) do
    socket
    |> read_line
    |> write_line(socket)

    serve(socket)
  end

  def read_line(socket) do
    {:ok, message} = :gen_tcp.recv(socket, 0)
    message
  end

  def write_line(message, socket) do
    :gen_tcp.send(socket, message)
  end

end
