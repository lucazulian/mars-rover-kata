defmodule MarsRoverKata.InputTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata.Input

  alias MarsRoverKata.Input

  test "parse correctly a valid input" do
    instructions = ~s(5 3\n1 1 E\nFBFBFBF)

    {:ok, input} = Input.parse(instructions)
    assert input.max_x == 5
  end

  test "return correctly an error on invalid nil input" do
    assert Input.parse(nil) == {:error, "invalid input data"}
  end

  test "return correctly an error on invalid empty input" do
    assert Input.parse("") == {:error, "invalid input data"}
  end
end
