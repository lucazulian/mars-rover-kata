defmodule MarsRoverKata.Instruction do
  @moduledoc """
  Apply instructions to robot position
  """

  alias MarsRoverKata.Planet
  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @spec perform_next(Planet.t(), Position.t(), atom) :: Position.t()
  def perform_next(
        %Planet{} = planet,
        %Position{} = position,
        instruction
      )
      when instruction in [:F, :B] do
    position
    |> perform(instruction)
    |> Planet.to_absolute_position(planet)
  end

  def perform_next(
        %Planet{} = _planet,
        %Position{} = position,
        instruction
      )
      when instruction in [:L, :R] do
    perform(position, instruction)
  end

  defp perform(%Position{point: point, direction: :N = direction}, :F),
    do: %Position{point: Point.new(point.x, point.y + 1), direction: direction}

  defp perform(%Position{point: point, direction: :N = direction}, :B),
    do: %Position{point: Point.new(point.x, point.y - 1), direction: direction}

  defp perform(%Position{point: point, direction: :S = direction}, :F),
    do: %Position{point: Point.new(point.x, point.y - 1), direction: direction}

  defp perform(%Position{point: point, direction: :S = direction}, :B),
    do: %Position{point: Point.new(point.x, point.y + 1), direction: direction}

  defp perform(%Position{point: point, direction: :W = direction}, :F),
    do: %Position{point: Point.new(point.x - 1, point.y), direction: direction}

  defp perform(%Position{point: point, direction: :W = direction}, :B),
    do: %Position{point: Point.new(point.x + 1, point.y), direction: direction}

  defp perform(%Position{point: point, direction: :E = direction}, :F),
    do: %Position{point: Point.new(point.x + 1, point.y), direction: direction}

  defp perform(%Position{point: point, direction: :E = direction}, :B),
    do: %Position{point: Point.new(point.x - 1, point.y), direction: direction}

  defp perform(%Position{point: point, direction: :N}, :L),
    do: %Position{point: point, direction: :W}

  defp perform(%Position{point: point, direction: :N}, :R),
    do: %Position{point: point, direction: :E}

  defp perform(%Position{point: point, direction: :S}, :L),
    do: %Position{point: point, direction: :E}

  defp perform(%Position{point: point, direction: :S}, :R),
    do: %Position{point: point, direction: :W}

  defp perform(%Position{point: point, direction: :W}, :L),
    do: %Position{point: point, direction: :S}

  defp perform(%Position{point: point, direction: :W}, :R),
    do: %Position{point: point, direction: :N}

  defp perform(%Position{point: point, direction: :E}, :L),
    do: %Position{point: point, direction: :N}

  defp perform(%Position{point: point, direction: :E}, :R),
    do: %Position{point: point, direction: :S}
end
