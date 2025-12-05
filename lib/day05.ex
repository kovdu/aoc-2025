defmodule Day05 do
  def read_ingredients(file) do
    f = file
    |> File.stream!()
    |> Stream.map(&String.trim/1)

    range =
      f |> Stream.take_while(fn s -> s != "" end)
        |> Enum.to_list()
        |> Enum.map(fn s -> String.split(s, "-") end)
        |> Enum.map(fn [s, e] -> {String.to_integer(s), String.to_integer(e)} end)

    ingredients =
      f |> Stream.drop_while(fn s -> s != "" end)
        |> Stream.drop(1)
        |> Enum.to_list()
        |> Enum.map(&String.to_integer/1)

    {range, ingredients}
  end

  def count_fresh_ingredients(range, ingredients) do
    ingredients
    |> Enum.filter(fn x -> Enum.any?(range, fn {s, e} -> x >= s && x <= e end) end)
    |> Enum.count()
  end

  def combine_ranges(remaining, processed) do
    case remaining do
      [] -> processed
      [a] -> processed ++ [a]
      [{s1, e1} = a, {s2, e2} | t] ->
        if e1 < s2 do
          combine_ranges([{s2, e2} | t], processed ++ [a])
        else
          combine_ranges([{s1, max(e1, e2)} | t], processed)
        end
    end
  end

  def count_fresh_ingredients_by_ranges(ranges) do
    Enum.sort(ranges) |> combine_ranges([]) |> Enum.map(fn {s, e} -> e - s + 1 end) |> Enum.sum()
  end

  def part1 do
    {range, ingredients} = read_ingredients("inputs/day05.txt")
    count_fresh_ingredients(range, ingredients)
  end

  def part2 do
    {ranges, _} = read_ingredients("inputs/day05.txt")
    count_fresh_ingredients_by_ranges(ranges)
  end
end
