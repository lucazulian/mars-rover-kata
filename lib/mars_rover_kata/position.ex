defmodule MarsRoverKata.Position do
  @moduledoc """
  Represent the rover position
  """

  alias MarsRoverKata.Point

  @type t :: %__MODULE__{
          point: Point.t(),
          direction: :N | :S | :W | :E
        }

  defstruct point: %Point{},
            direction: :N
end

defimpl String.Chars, for: MarsRoverKata.Position do
  alias MarsRoverKata.Position

  def to_string(%Position{point: point, direction: direction}) do
    "#{point}:#{direction}"
  end
end
