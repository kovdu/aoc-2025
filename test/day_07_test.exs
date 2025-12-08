defmodule Day07Test do
  use ExUnit.Case

  test "find_splitter" do
    grid = Day07.read_grid("inputs/day07_sample.txt")
    splitters = Day07.find_splitter(grid, grid |> Day07.get_start(), MapSet.new())
    assert splitters |> Enum.count() == 21
  end

  test "count_path" do
    grid = Day07.read_grid("inputs/day07_sample.txt")
    {count, _cache} = Day07.count_path(grid, grid |> Day07.get_start(), %{})
    assert count == 40
  end
end
