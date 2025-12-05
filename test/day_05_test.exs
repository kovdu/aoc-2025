defmodule Day05Test do
  use ExUnit.Case

  test "count_fresh_ingredients" do
    {range, ingredients} = Day05.read_ingredients("inputs/day05_sample.txt")
    assert Day05.count_fresh_ingredients(range, ingredients) == 3
  end
end
