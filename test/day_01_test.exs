defmodule Day01Test do
  use ExUnit.Case

  test "count_zeros" do
    sequence = Day01.read_sequences("inputs/day01_sample.txt")
    assert Day01.count_zeros(sequence, 50, 100) == {3, 32}
  end

  test "count_wraps" do
    assert Day01.count_wraps([{"R", 0}], 0, 100) == {0, 0}
    assert Day01.count_wraps([{"R", 100}], 0, 100) == {1, 0}
    assert Day01.count_wraps([{"R", 200}], 0, 100) == {2, 0}
    assert Day01.count_wraps([{"R", 201}], 0, 100) == {2, 1}
    assert Day01.count_wraps([{"R", 1000}], 50, 100) == {10, 50}

    assert Day01.count_wraps([{"L", 100}], 0, 100) == {1, 0}
    assert Day01.count_wraps([{"L", 1000}], 0, 100) == {10, 0}
    assert Day01.count_wraps([{"L", 1000}], 50, 100) == {10, 50}

    sequence = Day01.read_sequences("inputs/day01_sample.txt")
    assert Day01.count_wraps(sequence, 50, 100) == {6, 32}
  end
end
