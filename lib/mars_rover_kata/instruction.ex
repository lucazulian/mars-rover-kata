defmodule MarsRoverKata.Instruction do
  @moduledoc """
  Apply instructions to robot position.
  """

  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  @spec perform(Planet.t(), Position.t(), atom) :: Position.t()
  def perform(
        %Planet{} = planet,
        %Position{} = position,
        instruction
      ) do
    position
    |> do_perform(instruction)
    |> Planet.to_absolute_position(planet)
  end

  defp do_perform(%Position{x: x, y: y, direction: :N = direction}, :F),
    do: %Position{x: x, y: y + 1, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :N = direction}, :B),
    do: %Position{x: x, y: y - 1, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :S = direction}, :F),
    do: %Position{x: x, y: y - 1, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :S = direction}, :B),
    do: %Position{x: x, y: y + 1, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :W = direction}, :F),
    do: %Position{x: x - 1, y: y, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :W = direction}, :B),
    do: %Position{x: x + 1, y: y, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :E = direction}, :F),
    do: %Position{x: x + 1, y: y, direction: direction}

  defp do_perform(%Position{x: x, y: y, direction: :E = direction}, :B),
    do: %Position{x: x - 1, y: y, direction: direction}
end
