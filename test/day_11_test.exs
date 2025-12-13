defmodule Day11Test do
  use ExUnit.Case

  test "count_paths" do
    assert "inputs/day11_sample.txt"
           |> Day11.read_paths()
           |> Day11.revert_paths()
           |> Day11.count_paths("out", "you")
           |> elem(0) == 5
  end
end
