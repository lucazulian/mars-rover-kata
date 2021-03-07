defmodule MarsRoverKata.Planet do
  @moduledoc """
  Represent the planet in which the robot moves
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
    %Position{
      point:
        Point.new(
          Integer.mod(x, max_x),
          Integer.mod(y, max_y)
        ),
      direction: direction
    }
  end

  @spec has_obstacles?(__MODULE__.t(), Point.t()) :: boolean
  def has_obstacles?(%__MODULE__{obstacles: obstacles}, point) do
    Enum.any?(obstacles, &(&1 == point))
  end
end

defimpl String.Chars, for: MarsRoverKata.Planet do
  alias MarsRoverKata.Planet

  def to_string(%Planet{max_x: max_x, max_y: max_y}) do
    "#{max_x}:#{max_y}"
  end
end
