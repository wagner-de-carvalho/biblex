defmodule BiblexTest do
  use ExUnit.Case
  doctest Biblex

  test "greets the world" do
    assert Biblex.hello() == :world
  end
end
