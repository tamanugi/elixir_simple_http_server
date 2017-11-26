defmodule ElixirSimpleHttpServerTest do
  use ExUnit.Case
  doctest ElixirSimpleHttpServer

  test "greets the world" do
    assert ElixirSimpleHttpServer.hello() == :world
  end
end
