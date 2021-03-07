defmodule MarsRoverKata.InstructionTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata.Instruction

  alias MarsRoverKata.Instruction
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @planet %Planet{max_x: 5, max_y: 5}

  values = [
    [
      %Position{point: Point.new(0, 0), direction: :N},
      :F,
      %Position{point: Point.new(0, 1), direction: :N}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :N},
      :B,
      %Position{point: Point.new(0, 4), direction: :N}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :S},
      :F,
      %Position{point: Point.new(0, 4), direction: :S}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :S},
      :B,
      %Position{point: Point.new(0, 1), direction: :S}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :W},
      :F,
      %Position{point: Point.new(4, 0), direction: :W}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :W},
      :B,
      %Position{point: Point.new(1, 0), direction: :W}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :E},
      :F,
      %Position{point: Point.new(1, 0), direction: :E}
    ],
    [
      %Position{point: Point.new(0, 0), direction: :E},
      :B,
      %Position{point: Point.new(4, 0), direction: :E}
    ]
  ]

  for [position, instruction, expected] <- values do
    @position position
    @instruction instruction
    @expected expected

    test "correctly move on planet #{@planet} from position #{position} with instruction #{
           instruction
         }" do
      assert Instruction.perform_next(@planet, @position, @instruction) == @expected
    end
  end
end
