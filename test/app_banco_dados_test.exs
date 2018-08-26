defmodule AppBancoDadosTest do
  use ExUnit.Case
  doctest AppBancoDados

  test "greets the world" do
    assert AppBancoDados.hello() == :world
  end
end
