defmodule MarsRoverKata.InputTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata.Input

  alias MarsRoverKata.Input

  test "parse correctly a valid input" do
    instructions = ~s(5:3\n\n1:1:E\nFBFBFBF)

    {:ok, input} = Input.parse(instructions)
    assert input.max_x == 5
    assert input.instructions == [:F, :B, :F, :B, :F, :B, :F]
  end

  test "parse correctly a valid input with obstacles" do
    instructions = ~s(5:3\n0:0 1:1\n1:1:E\nFBFBFBF)

    {:ok, input} = Input.parse(instructions)
    assert input.max_x == 5
    assert input.instructions == [:F, :B, :F, :B, :F, :B, :F]

    assert input.obstacles == [
             %MarsRoverKata.Point{x: 0, y: 0},
             %MarsRoverKata.Point{x: 1, y: 1}
           ]
  end

  test "return correctly an error on invalid nil input" do
    assert Input.parse(nil) == {:error, "invalid input data"}
  end

  test "return correctly an error on invalid empty input" do
    assert Input.parse("") == {:error, "invalid input data"}
  end
end
