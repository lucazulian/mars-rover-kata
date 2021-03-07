defmodule MarsRoverKata.InstructionTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata.Instruction

  alias MarsRoverKata.Instruction
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  @planet %Planet{max_x: 5, max_y: 5}

  values = [
    [
      %Position{x: 0, y: 0, direction: :N},
      :F,
      %Position{x: 0, y: 1, direction: :N}
    ],
    [
      %Position{x: 0, y: 0, direction: :N},
      :B,
      %Position{x: 0, y: 4, direction: :N}
    ],
    [
      %Position{x: 0, y: 0, direction: :S},
      :F,
      %Position{x: 0, y: 4, direction: :S}
    ],
    [
      %Position{x: 0, y: 0, direction: :S},
      :B,
      %Position{x: 0, y: 1, direction: :S}
    ],
    [
      %Position{x: 0, y: 0, direction: :W},
      :F,
      %Position{x: 4, y: 0, direction: :W}
    ],
    [
      %Position{x: 0, y: 0, direction: :W},
      :B,
      %Position{x: 1, y: 0, direction: :W}
    ],
    [
      %Position{x: 0, y: 0, direction: :E},
      :F,
      %Position{x: 1, y: 0, direction: :E}
    ],
    [
      %Position{x: 0, y: 0, direction: :E},
      :B,
      %Position{x: 4, y: 0, direction: :E}
    ]
  ]

  for [position, instruction, expected] <- values do
    @position position
    @instruction instruction
    @expected expected

    test "correctly move on planet #{@planet} from position #{position} with instruction #{
           instruction
         }" do
      assert Instruction.perform(@planet, @position, @instruction) == @expected
    end
  end
end
