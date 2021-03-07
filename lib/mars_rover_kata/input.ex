defmodule MarsRoverKata.Input do
  @moduledoc """
  Converting input instruction strings into actionable terms.

  The input should be someting like:

  5 3
  1 1 E
  FBFBFBF

  Where
  - the first line represent the maximux X and Y in the grid;
  - the secondo line represent the actual position and orientation for the rover;
  - the last line represent actionable instruction terms.
  """

  alias MarsRoverKata.Position

  @type t :: %__MODULE__{
          max_x: integer(),
          max_y: integer(),
          position: Position.t(),
          instructions: list(:F | :B)
        }

  defstruct max_x: 0,
            max_y: 0,
            position: %Position{},
            instructions: []

  @spec parse(String.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def parse(input) when is_binary(input) and byte_size(input) > 0 do
    [grid_dimension | [position | [sets | _rest]]] = String.split(input, "\n")

    [x, y] = parse_grid_dimension(grid_dimension)

    {:ok,
     %__MODULE__{
       max_x: x,
       max_y: y,
       instructions: parse_instructions(sets),
       position: parse_position(position)
     }}
  end

  def parse(_) do
    {:error, "invalid input data"}
  end

  defp parse_grid_dimension(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&parse_int/1)
  end

  defp parse_instructions(line) do
    line
    |> String.split("", trim: true)
    |> Enum.map(&to_atom/1)
  end

  defp parse_position(line) do
    [x, y, direction] = String.split(line, " ")

    %Position{
      x: parse_int(x),
      y: parse_int(y),
      direction: to_atom(direction)
    }
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
