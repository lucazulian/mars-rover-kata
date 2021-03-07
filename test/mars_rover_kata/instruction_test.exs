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
    [:N, :N, [0, 1], :F],
    [:N, :N, [0, 4], :B],
    [:S, :S, [0, 4], :F],
    [:S, :S, [0, 1], :B],
    [:W, :W, [4, 0], :F],
    [:W, :W, [1, 0], :B],
    [:E, :E, [1, 0], :F],
    [:E, :E, [4, 0], :B]
  ]

  for [direction, expected_direction, [expected_x, expected_y], instruction] <- values do
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
