defmodule MarsRoverKata do
  @moduledoc false

  alias MarsRoverKata.Input

  def explore(input) do
    case Input.parse(input) do
      {:ok, parsed} ->
        parsed

      error ->
        error
    end
  end
end
