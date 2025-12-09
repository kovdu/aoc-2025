defmodule Day08Test do
  use ExUnit.Case

  test "connect" do
    assert "inputs/day08_sample.txt"
           |> Day08.read_positions()
           |> Day08.connect(10)
           |> Day08.multiply_size_of_largest_circuits(3) == 40
  end

  test "connect_until_one_set" do
    assert "inputs/day08_sample.txt"
           |> Day08.read_positions()
           |> Day08.connect_until_one_set()
           |> Day08.multiply_x_positions() == 25272
  end
end
