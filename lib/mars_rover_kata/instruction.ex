defmodule MarsRoverKata.Instruction do
  @moduledoc """
  Apply instructions to robot position
  """

  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  @spec perform(Planet.t(), Position.t(), atom) :: Position.t()
  def perform(
        %Planet{} = planet,
        %Position{} = position,
        instruction
      )
      when instruction in [:F, :B] do
    position
    |> do_perform(instruction)
    |> Planet.to_absolute_position(planet)
  end

  def perform(
        %Planet{} = _planet,
        %Position{} = position,
        instruction
      )
      when instruction in [:L, :R] do
    do_perform(position, instruction)
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

  defp do_perform(%Position{x: x, y: y, direction: :N}, :L),
    do: %Position{x: x, y: y, direction: :W}

  defp do_perform(%Position{x: x, y: y, direction: :N}, :R),
    do: %Position{x: x, y: y, direction: :E}

  defp do_perform(%Position{x: x, y: y, direction: :S}, :L),
    do: %Position{x: x, y: y, direction: :E}

  defp do_perform(%Position{x: x, y: y, direction: :S}, :R),
    do: %Position{x: x, y: y, direction: :W}

  defp do_perform(%Position{x: x, y: y, direction: :W}, :L),
    do: %Position{x: x, y: y, direction: :S}

  defp do_perform(%Position{x: x, y: y, direction: :W}, :R),
    do: %Position{x: x, y: y, direction: :N}

  defp do_perform(%Position{x: x, y: y, direction: :E}, :L),
    do: %Position{x: x, y: y, direction: :N}

  defp do_perform(%Position{x: x, y: y, direction: :E}, :R),
    do: %Position{x: x, y: y, direction: :S}
end
