defmodule MarsRoverKata.Instruction do
  @moduledoc """
  Apply instructions to robot position.
  """

  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  @spec perform(Planet.t(), Position.t(), atom) :: Position.t()
  def perform(
        %Planet{max_x: _max_x, max_y: _max_y},
        %Position{x: x, y: y, direction: :N},
        :F
      ) do
    %Position{x: x, y: y + 1}
  end
end
