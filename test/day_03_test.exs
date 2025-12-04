defmodule Day03Test do
  use ExUnit.Case

  test "calculate_max_joltage" do
    assert 6767 |> Integer.digits() |> Day03.calculate_max_joltage() == 77
    assert 67678 |> Integer.digits() |> Day03.calculate_max_joltage() == 78
    assert 676_781 |> Integer.digits() |> Day03.calculate_max_joltage() == 81

    assert "inputs/day03_sample.txt"
           |> Day03.read_joltages()
           |> Enum.map(fn b -> Day03.calculate_max_joltage(b) end)
           |> Enum.sum() == 357
  end

  test "maximize_joltage" do
    assert Day03.maximize_joltage(1, []) == []
    assert Day03.maximize_joltage(1, [2]) == [2]
    assert Day03.maximize_joltage(2, [1]) == [2]
    assert Day03.maximize_joltage(1, [2, 3]) == [2, 3]
    assert Day03.maximize_joltage(3, [1, 2]) == [3, 2]
    assert Day03.maximize_joltage(5, [2, 4, 2, 1]) == [5, 4, 2, 1]
    assert Day03.maximize_joltage(5, [2, 4, 2, 1]) == [5, 4, 2, 1]
    assert Day03.maximize_joltage(6, [5, 4, 2, 1]) == [6, 5, 4, 2]
  end

  test "calculate_max_joltage_for_size" do
    assert 6767 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(2) == 77
    assert 67678 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(2) == 78
    assert 676_781 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(2) == 81

    assert 921_314 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(5) == 92314

    assert 818_181_911_112_111 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(12) ==
             888_911_112_111

    assert 918_181_911_112_111 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(12) ==
             988_911_112_111

    assert 618_181_911_112_111 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(12) ==
             881_911_112_111

    assert 53421 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(4) == 5421

    assert 7_152_242_222_112_122_421 |> Integer.digits() |> Day03.calculate_max_joltage_for_size(12) ==
             754_222_222_421

    assert "inputs/day03_sample.txt"
           |> Day03.read_joltages()
           |> Enum.map(fn b -> Day03.calculate_max_joltage_for_size(b, 12) end)
           |> Enum.sum() == 3_121_910_778_619
  end
end
