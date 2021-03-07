defmodule MarsRoverKata.Planet do
  @moduledoc """
  Represent the planet in which the robot moves
  """

  @type t :: %__MODULE__{
          max_x: integer(),
          max_y: integer()
        }

  defstruct max_x: 0,
            max_y: 0
end
