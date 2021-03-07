defmodule MarsRoverKata do
  @moduledoc false

  alias MarsRoverKata.Input
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position
  alias MarsRoverKata.Instruction

  @spec explore(String.t()) :: String.t()
  @spec explore(Planet.t(), Position.t(), list(atom)) :: Position.t()

  def explore(input) do
    case Input.parse(input) do
      {:ok, parsed} ->
        %Planet{max_x: parsed.max_x, max_y: parsed.max_y}
        |> explore(parsed.position, parsed.instructions)
        |> to_string()

      {:error, error} ->
        error
    end
  end

  def explore(
        %Planet{} = _planet,
        %Position{} = position,
        []
      ) do
    position
  end

  def explore(
        %Planet{} = planet,
        %Position{} = position,
        [instruction | instructions]
      ) do
    new_position = Instruction.perform(planet, position, instruction)
    explore(planet, new_position, instructions)
  end
end
