defmodule MarsRoverKata.InstructionTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata.Instruction

  alias MarsRoverKata.Instruction
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  test "parse correctly a valid input" do
    planet = %Planet{max_x: 5, max_y: 5}
    position = %Position{x: 0, y: 0, direction: :N}

    next_position = Instruction.perform(planet, position, :F)

    assert next_position == %Position{x: 0, y: 1}
  end
end
