defmodule Day06Test do
  use ExUnit.Case

  test "read_problems_part1" do
    assert "inputs/day06_sample.txt"
           |> Day06.read_problems_part1()
           |> Day06.handle_problems()
           |> Enum.sum() == 4_277_556
  end

  test "read_problems_part2" do
    assert "inputs/day06_sample.txt"
           |> Day06.read_problems_part2()
           |> Day06.handle_problems()
           |> Enum.sum() == 3_263_827
  end
end
