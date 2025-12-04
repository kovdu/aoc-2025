defmodule Day04Test do
  use ExUnit.Case

  test "count_rolls_of_paper" do
    assert "inputs/day04_sample.txt"
           |> Day04.read_grid()
           |> Day04.count_rolls_of_paper()
           |> Enum.count(fn {_pos, v} -> v < 4 end) == 13
  end

  test "clear_grid" do
    assert "inputs/day04_sample.txt"
           |> Day04.read_grid()
           |> Day04.clear_grid()
           |> elem(0) ==
             43
  end
end
