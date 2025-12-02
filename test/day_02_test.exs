defmodule Day02Test do
  use ExUnit.Case

  test "find_all_invalid_ids" do
    ranges = Day02.read_ranges("inputs/day02_sample.txt")
    assert Day02.find_all_invalid_ids(ranges) |> Enum.sum() == 1_227_775_554
  end

  test "has_repeated_sequences?" do
    assert Day02.has_repeated_sequences?(11) == true
    assert Day02.has_repeated_sequences?(12) == false
    assert Day02.has_repeated_sequences?(824_824_824) == true
    assert Day02.has_repeated_sequences?(2_121_212_121) == true
    assert Day02.has_repeated_sequences?(2_121_222_121) == false
  end

  test "find_all_ids_with_repeated_sequences" do
    ranges = Day02.read_ranges("inputs/day02_sample.txt")
    assert Day02.find_all_ids_with_repeated_sequences(ranges) |> Enum.sum() == 4_174_379_265
  end
end
