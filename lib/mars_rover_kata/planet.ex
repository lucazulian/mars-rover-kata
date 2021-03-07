defmodule MarsRoverKata.Planet do
  @moduledoc """
  Represent the planet in which the robot moves
  """

  alias MarsRoverKata.Position

  @type t :: %__MODULE__{
          max_x: integer(),
          max_y: integer()
        }

  defstruct max_x: 0,
            max_y: 0

  @doc ~S"""
  Transforms a relative position to an absolute based a planet shape

  ## Examples

      iex> MarsRoverKata.Planet.to_absolute_position(%MarsRoverKata.Position{x: -1, y: -1}, %MarsRoverKata.Planet{max_x: 5, max_y: 5})
      %MarsRoverKata.Position{x: 4, y: 4}

      iex> MarsRoverKata.Planet.to_absolute_position(%MarsRoverKata.Position{x: 12, y: 12}, %MarsRoverKata.Planet{max_x: 5, max_y: 5})
      %MarsRoverKata.Position{x: 2, y: 2}

  """
  @spec to_absolute_position(__MODULE__.t(), Position.t()) :: Position.t()
  def to_absolute_position(
        %Position{
          x: x,
          y: y,
          direction: direction
        },
        %__MODULE__{max_x: max_x, max_y: max_y}
      ) do
    %Position{
      x: Integer.mod(x, max_x),
      y: Integer.mod(y, max_y),
      direction: direction
    }
  end
end
