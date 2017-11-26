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
    case read_line(socket) do
      :continue -> serve(socket)
      :end -> response(socket)
    end
  end

  def read_line(socket) do
    {:ok, message} = :gen_tcp.recv(socket, 0)

    case String.split(message, " ") do
      [_method, _target, _version] ->
        :continue
      [_field_name, _field_value] ->
        :continue
      _ ->
        :end
    end
  end

  def response(socket) do

    message = 
"""
HTTP/1.1 200 OK
Content-Length: 12

HELLO WORLD!
"""

    :gen_tcp.send(socket, message)
    :gen_tcp.close(socket)
  end

end
