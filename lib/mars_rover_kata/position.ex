defmodule MarsRoverKata.Position do
  @moduledoc """
  Represent the rover position
  """

  @type t :: %__MODULE__{
          x: integer(),
          y: integer(),
          direction: :N | :S | :W | :E
        }

  defstruct x: 0,
            y: 0,
            direction: :N
end

defimpl String.Chars, for: MarsRoverKata.Position do
  alias MarsRoverKata.Position

  def to_string(%Position{x: x, y: y, direction: direction}) do
    "#{x}:#{y}:#{direction}"
  end
end
