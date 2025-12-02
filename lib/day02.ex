defmodule Day02 do
  def read_ranges(file) do
    file
    |> File.stream!()
    |> Enum.at(0)
    |> String.split(",")
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.map(fn [s, e] -> {String.to_integer(s), String.to_integer(e)} end)
  end

  defp adjust_range({s, e}) do
    s_len = String.length(to_string(s))
    e_len = String.length(to_string(e))

    new_s = if rem(s_len, 2) == 1, do: Integer.pow(10, s_len), else: s
    new_e = if rem(e_len, 2) == 1, do: Integer.pow(10, e_len - 1) - 1, else: e

    {new_s, new_e}
  end

  def find_invalid_ids_in_range(range) do
    {s, e} = adjust_range(range)
    {ss, es} = {to_string(s), to_string(e)}

    {ss_left, _} = String.split_at(ss, div(String.length(ss), 2))
    {es_left, _} = String.split_at(es, div(String.length(es), 2))

    for i <- String.to_integer(ss_left)..String.to_integer(es_left)//1 do
      String.to_integer(to_string(i) <> to_string(i))
    end
    |> Enum.filter(fn x -> x >= s && x <= e end)
  end

  def find_all_invalid_ids(ranges) do
    ranges
    |> Stream.flat_map(&find_invalid_ids_in_range/1)
  end

  def has_repeated_group(id, group_size) do
    digits = Integer.digits(id)
    digit_count = length(digits)

    if rem(digit_count, group_size) != 0 do
      false
    end

    chunks =
      digits
      |> Enum.chunk_every(group_size)
      |> Enum.map(&Integer.undigits/1)

    case chunks do
      [first | rest] ->
        Enum.all?(rest, fn y -> y == first end)

      [] ->
        false
    end
  end

  def has_twice_repeated_sequence?(id) do
    digits = Integer.digits(id)
    digit_count = length(digits)

    if rem(digit_count, 2) != 0 do
      false
    else
      has_repeated_group(id, div(digit_count, 2))
    end
  end

  def has_repeated_sequences?(id) do
    digits = Integer.digits(id)
    digit_count = length(digits)

    (digit_count - 1)..1//-1
    |> Enum.filter(fn x -> rem(digit_count, x) == 0 end)
    |> Enum.any?(fn x -> has_repeated_group(id, x) end)
  end

  def find_ids_with_repeated_sequences({s, e}) do
    s..e |> Stream.filter(&has_repeated_sequences?/1)
  end

  def part1 do
    "inputs/day02.txt"
    |> read_ranges()
    |> find_all_invalid_ids()
    |> Enum.sum()
  end

  def part1_alternative do
    "inputs/day02.txt"
    |> read_ranges()
    |> Enum.flat_map(fn {s, e} ->
      s..e
      |> Stream.filter(&has_twice_repeated_sequence?/1)
    end)
    |> Enum.sum()
  end

  def find_all_ids_with_repeated_sequences(ranges) do
    ranges
    |> Enum.flat_map(&find_ids_with_repeated_sequences/1)
  end

  def part2 do
    "inputs/day02.txt"
    |> read_ranges()
    |> find_all_ids_with_repeated_sequences()
    |> Enum.sum()
  end
end
