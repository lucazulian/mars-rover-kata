defmodule MarsRoverKataTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata

  alias MarsRoverKata
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @planet %Planet{max_x: 5, max_y: 5}
  @starting_point Point.new(0, 0)

  values = [
    [
      %Position{point: @starting_point, direction: :N},
      [],
      %Position{point: @starting_point, direction: :N}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:R],
      %Position{point: @starting_point, direction: :E}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:R, :R],
      %Position{point: @starting_point, direction: :S}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:R, :R, :R],
      %Position{point: @starting_point, direction: :W}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:R, :R, :R, :R],
      %Position{point: @starting_point, direction: :N}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:L],
      %Position{point: @starting_point, direction: :W}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:L, :L],
      %Position{point: @starting_point, direction: :S}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:L, :L, :L],
      %Position{point: @starting_point, direction: :E}
    ],
    [
      %Position{point: @starting_point, direction: :N},
      [:L, :L, :L, :L],
      %Position{point: @starting_point, direction: :N}
    ]
  ]

  for [position, instructions, expected] <- values do
    @position position
    @instructions instructions
    @expected expected

    test "correctly follow path on planet #{@planet} from position #{position} with instructions #{
           inspect(instructions)
         }" do
      assert MarsRoverKata.explore(@planet, @position, @instructions) == {:ok, @expected}
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

  test "correctly stop following path with valid input and obstacles" do
    planet = %Planet{max_x: 5, max_y: 5, obstacles: [Point.new(0, 1)]}

    assert MarsRoverKata.explore(
             planet,
             %Position{point: Point.new(0, 0), direction: :N},
             [:F, :R]
           ) ==
             {:error,
              %MarsRoverKata.Position{direction: :N, point: %MarsRoverKata.Point{x: 0, y: 0}},
              %MarsRoverKata.Point{x: 0, y: 1}}
  end
end
