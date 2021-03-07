defmodule MarsRoverKataTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata

  alias MarsRoverKata
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  @planet %Planet{max_x: 5, max_y: 5}

  values = [
    [%Position{x: 0, y: 0, direction: :N}, [], %Position{x: 0, y: 0, direction: :N}],
    [%Position{x: 0, y: 0, direction: :N}, [:R], %Position{x: 0, y: 0, direction: :E}],
    [%Position{x: 0, y: 0, direction: :N}, [:R, :R], %Position{x: 0, y: 0, direction: :S}],
    [%Position{x: 0, y: 0, direction: :N}, [:R, :R, :R], %Position{x: 0, y: 0, direction: :W}],
    [
      %Position{x: 0, y: 0, direction: :N},
      [:R, :R, :R, :R],
      %Position{x: 0, y: 0, direction: :N}
    ],
    [%Position{x: 0, y: 0, direction: :N}, [:L], %Position{x: 0, y: 0, direction: :W}],
    [%Position{x: 0, y: 0, direction: :N}, [:L, :L], %Position{x: 0, y: 0, direction: :S}],
    [%Position{x: 0, y: 0, direction: :N}, [:L, :L, :L], %Position{x: 0, y: 0, direction: :E}],
    [%Position{x: 0, y: 0, direction: :N}, [:L, :L, :L, :L], %Position{x: 0, y: 0, direction: :N}]
  ]

  for [position, instructions, expected] <- values do
    @position position
    @instructions instructions
    @expected expected

    test "correctly follow path on planet #{@planet} from position #{position} with instructions #{
           inspect(instructions)
         }" do
      assert MarsRoverKata.explore(@planet, @position, @instructions) == @expected
    end
  end

  test "correctly follow path with valid input" do
    assert MarsRoverKata.explore(~s(5 3\n1 1 E\nFBFBFBF)) == "2:1:E"
  end

  test "return error with invalid input" do
    assert MarsRoverKata.explore(nil) == "invalid input data"
  end
end
