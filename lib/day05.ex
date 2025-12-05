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

  def part1 do
    {range, ingredients} = read_ingredients("inputs/day05.txt")
    count_fresh_ingredients(range, ingredients)
  end

  def part2 do

  end
end
