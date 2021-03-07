defmodule Mix.Tasks.Play do
  @moduledoc false

  use Mix.Task

  @shortdoc "Play with robot"
  def run(_argv) do
    result =
      :all
      |> IO.read()
      |> MarsRoverKata.explore()

    IO.puts("hey, #{result}")
  end
end
