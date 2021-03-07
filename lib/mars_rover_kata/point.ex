defmodule MarsRoverKata.Point do
  @moduledoc """
  Represent a single point
  """

  @type t :: %__MODULE__{
          x: integer(),
          y: integer()
        }

  defstruct x: 0,
            y: 0

  @spec new(integer, integer) :: __MODULE__.t()
  def new(x, y) do
    %__MODULE__{x: x, y: y}
  end
end

defimpl String.Chars, for: MarsRoverKata.Point do
  alias MarsRoverKata.Point

  def to_string(%Point{x: x, y: y}) do
    "#{x}:#{y}"
  end
end
