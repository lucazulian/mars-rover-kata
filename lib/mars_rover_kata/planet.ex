defmodule MarsRoverKata.Planet do
  @moduledoc """
  Represent the planet in which the robot moves.

  The planet is represented by a grid of max_x * max_y shape on zero based
  system and is a sphere so connects vertical edges towards themselves are
  in inverted coordinates.
  """

  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @type t :: %__MODULE__{
          max_x: integer(),
          max_y: integer(),
          obstacles: list(Point.t())
        }

  defstruct max_x: 0,
            max_y: 0,
            obstacles: []

  @doc ~S"""
  Transforms a relative position to an absolute based a planet shape

  ## Examples

      iex> MarsRoverKata.Planet.to_absolute_position(%MarsRoverKata.Position{point: MarsRoverKata.Point.new(-1, -1)}, %MarsRoverKata.Planet{max_x: 5, max_y: 5})
      %MarsRoverKata.Position{point: %MarsRoverKata.Point{x: 4, y: 4}}

      iex> MarsRoverKata.Planet.to_absolute_position(%MarsRoverKata.Position{point: MarsRoverKata.Point.new(12, 12)}, %MarsRoverKata.Planet{max_x: 5, max_y: 5})
      %MarsRoverKata.Position{point: %MarsRoverKata.Point{x: 2, y: 2}}

      iex> MarsRoverKata.Planet.to_absolute_position(%MarsRoverKata.Position{point: MarsRoverKata.Point.new(-1, 1)}, %MarsRoverKata.Planet{max_x: 5, max_y: 5})
      %MarsRoverKata.Position{point: %MarsRoverKata.Point{x: 4, y: 1}}

      iex> MarsRoverKata.Planet.to_absolute_position(%MarsRoverKata.Position{point: MarsRoverKata.Point.new(1, -1)}, %MarsRoverKata.Planet{max_x: 5, max_y: 5})
      %MarsRoverKata.Position{point: %MarsRoverKata.Point{x: 4, y: 1}}

  """
  @spec to_absolute_position(__MODULE__.t(), Position.t()) :: Position.t()
  def to_absolute_position(
        %Position{
          point: %Point{
            x: x,
            y: y
          },
          direction: direction
        },
        %__MODULE__{max_x: max_x, max_y: max_y}
      ) do
    point =
      if max_y < y || y < 0 do
        Point.new(
          one_based_mod(y, max_y),
          one_based_mod(x, max_x)
        )
      else
        Point.new(
          one_based_mod(x, max_x),
          one_based_mod(y, max_y)
        )
      end

    %Position{
      point: point,
      direction: direction
    }
  end

  @spec has_obstacles?(__MODULE__.t(), Point.t()) :: boolean
  def has_obstacles?(%__MODULE__{obstacles: obstacles}, point) do
    Enum.any?(obstacles, &(&1 == point))
  end

  @spec one_based_mod(integer, neg_integer | pos_integer) :: integer
  defp one_based_mod(dividend, divisor) do
    remainder = rem(dividend, divisor)

    if remainder * divisor < 0 do
      remainder + divisor
    else
      remainder
    end
  end
end

defimpl String.Chars, for: MarsRoverKata.Planet do
  alias MarsRoverKata.Planet

  def to_string(%Planet{max_x: max_x, max_y: max_y}) do
    "#{max_x}:#{max_y}"
  end
end
