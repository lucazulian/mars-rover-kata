defmodule MarsRoverKata.InstructionTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest MarsRoverKata.Instruction

  alias MarsRoverKata.Instruction
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @planet %Planet{max_x: 5, max_y: 5}
  @starting_point Point.new(0, 0)

  values = [
    [:N, [0, 1, :N], :F],
    [:N, [4, 0, :N], :B],
    [:S, [4, 0, :S], :F],
    [:S, [0, 1, :S], :B],
    [:W, [4, 0, :W], :F],
    [:W, [1, 0, :W], :B],
    [:E, [1, 0, :E], :F],
    [:E, [4, 0, :E], :B]
  ]

  for [direction, [expected_x, expected_y, expected_direction], instruction] <- values do
    @position %Position{point: @starting_point, direction: direction}
    @instruction instruction
    @expected %Position{point: Point.new(expected_x, expected_y), direction: expected_direction}

    test ~s(correctly move on planet #{@planet} from position #{@position} with instruction #{
           @instruction
         }) do
      assert Instruction.perform_next(@planet, @position, @instruction) == @expected
    end
  end
end
