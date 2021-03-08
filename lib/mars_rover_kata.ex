defmodule MarsRoverKata do
  @moduledoc false

  alias MarsRoverKata.Input
  alias MarsRoverKata.Instruction
  alias MarsRoverKata.Planet
  alias MarsRoverKata.Position

  @spec explore(String.t()) :: String.t()
  @spec explore(Planet.t(), Position.t(), list(atom)) ::
          {:ok, Position.t()} | {:error, {Position.t(), Point.t()}}

  def explore(input) do
    case Input.parse(input) do
      {:ok, parsed} ->
        %Planet{
          max_x: parsed.max_x,
          max_y: parsed.max_y,
          obstacles: parsed.obstacles
        }
        |> explore(parsed.position, parsed.instructions)
        |> parse_result()

      {:error, error} ->
        error
    end
  rescue
    _error ->
      "malformed input"
  end

  def explore(
        %Planet{} = _planet,
        %Position{} = position,
        []
      ) do
    {:ok, position}
  end

  def explore(
        %Planet{} = planet,
        %Position{} = position,
        [instruction | instructions]
      ) do
    new_position = Instruction.perform_next(planet, position, instruction)

    if Planet.has_obstacles?(planet, new_position.point) do
      {:error, {position, new_position.point}}
    else
      explore(planet, new_position, instructions)
    end
  end

  defp parse_result({:ok, position}), do: "reach #{position}"
  defp parse_result({:error, {position, obstacle}}), do: "stop #{position} - #{obstacle}"
end
