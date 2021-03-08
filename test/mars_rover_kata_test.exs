defmodule MarsRoverKataTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata

  alias MarsRoverKata
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @planet %Planet{max_x: 5, max_y: 5}
  @starting_position %Position{point: Point.new(0, 0), direction: :N}

  values = [
    [[0, 0, :N], []],
    [[0, 0, :E], [:R]],
    [[0, 0, :S], [:R, :R]],
    [[0, 0, :W], [:R, :R, :R]],
    [[0, 0, :N], [:R, :R, :R, :R]],
    [[0, 0, :W], [:L]],
    [[0, 0, :S], [:L, :L]],
    [[0, 0, :E], [:L, :L, :L]],
    [[0, 0, :N], [:L, :L, :L, :L]],
    [[0, 1, :N], [:F]],
    [[0, 3, :N], [:F, :F, :F]],
    [[0, 0, :N], [:F, :B, :B, :F]],
    [[0, 2, :S], [:F, :F, :F, :F, :F, :R, :R, :F, :F, :F]],
    [[1, 0, :E], [:R, :F]],
    [[0, 0, :E], [:R, :F, :F, :F, :F, :F]],
    [[0, 0, :W], [:R, :F, :R, :R, :F]],
    [[3, 0, :W], [:R, :F, :F, :F, :F, :F, :R, :R, :F, :F]],
    [[0, 0, :N], [:F, :F, :F, :F, :F, :F, :F, :F, :F, :F]],
    [[0, 0, :N], [:F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F]],
    [[0, 4, :S], [:R, :R, :F]],
    [[0, 0, :S], [:R, :R, :F, :F, :F, :F, :F]],
    [[0, 0, :E], [:R, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F]],
    [[0, 0, :E], [:R, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F, :F]],
    [[4, 0, :W], [:L, :F]],
    [[0, 0, :W], [:L, :F, :F, :F, :F, :F]]
  ]

  for [[expected_x, expected_y, expected_direction], instructions] <- values do
    @instructions instructions
    @expected %Position{point: Point.new(expected_x, expected_y), direction: expected_direction}

    test ~s(correctly follow path on planet #{@planet} from position #{@starting_position} with instructions #{
           inspect(@instructions)
         }) do
      assert MarsRoverKata.explore(@planet, @starting_position, @instructions) == {:ok, @expected}
    end
  end

  test "correctly follow path with valid string input" do
    assert MarsRoverKata.explore(~s(5:3\n\n1:1:E\nFBFBFBF)) == "reach 2:1:E"
  end

  test "correctly stop following path with valid string input and obstacles" do
    assert MarsRoverKata.explore(~s(5:5\n0:1\n0:0:N\nFR)) == "stop 0:0:N - 0:1"
  end

  test "return error with invalid input" do
    assert MarsRoverKata.explore(nil) == "invalid input data"
  end

  test "return error with malformed input" do
    assert MarsRoverKata.explore(~s(5:5\n)) == "malformed input"
  end

  test "correctly stop following path with valid input and obstacles" do
    planet = %Planet{max_x: 5, max_y: 5, obstacles: [Point.new(0, 1)]}

    assert MarsRoverKata.explore(
             planet,
             %Position{point: Point.new(0, 0), direction: :N},
             [:F, :R]
           ) ==
             {:error,
              {%MarsRoverKata.Position{direction: :N, point: %MarsRoverKata.Point{x: 0, y: 0}},
               %MarsRoverKata.Point{x: 0, y: 1}}}
  end
end
