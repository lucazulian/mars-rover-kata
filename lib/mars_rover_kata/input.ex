defmodule MarsRoverKata.Input do
  @moduledoc """
  Converting input instruction strings into actionable terms.

  The input should be someting like:

  5:3
  0:0 0:1
  1:1:E
  FBFBFBF

  Where
  - the first line represent the maximux X and Y in the grid;
  - the second lie represent a list of obstacle points;
  - the third line represent the actual position and orientation for the rover;
  - the last line represent actionable instruction terms.
  """

  alias MarsRoverKata.Point
  alias MarsRoverKata.Position

  @type t :: %__MODULE__{
          max_x: integer(),
          max_y: integer(),
          obstacles: list(Point.t()),
          position: Position.t(),
          instructions: list(:F | :B)
        }

  defstruct max_x: 0,
            max_y: 0,
            obstacles: [],
            position: %Position{},
            instructions: []

  @spec parse(String.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def parse(input) when is_binary(input) and byte_size(input) > 0 do
    [grid_dimension | [obstacles | [position | [sets | _rest]]]] = String.split(input, "\n")

    [x, y] = parse_grid_dimension(grid_dimension)

    {:ok,
     %__MODULE__{
       max_x: x,
       max_y: y,
       obstacles: parse_obstacles(obstacles),
       instructions: parse_instructions(sets),
       position: parse_position(position)
     }}
  end

  def parse(_) do
    {:error, "invalid input data"}
  end

  defp parse_grid_dimension(line) do
    line
    |> String.split(":", trim: true)
    |> Enum.map(&parse_int/1)
  end

  defp parse_instructions(line) do
    line
    |> String.split("", trim: true)
    |> Enum.map(&to_atom/1)
  end

  defp parse_position(line) do
    [x, y, direction] = String.split(line, ":")

    %Position{
      point: %Point{
        x: parse_int(x),
        y: parse_int(y)
      },
      direction: to_atom(direction)
    }
  end

  defp parse_obstacles(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(fn obstacle ->
      [x, y] = String.split(obstacle, ":")

      %Point{
        x: parse_int(x),
        y: parse_int(y)
      }
    end)
  end

  defp to_atom(string) do
    string
    |> String.upcase()
    |> String.to_atom()
  end

  defp parse_int(string) do
    {int, _} = Integer.parse(string)

    int
  end
end
