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
