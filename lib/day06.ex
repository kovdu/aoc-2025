defmodule Day06 do
  def read_problems_part1(file) do
    rows =
      file
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.split(&1, ~r{\s}, trim: true))
      |> Enum.to_list()

    {
      rows
      |> Enum.drop(-1)
      |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1),
      rows |> Enum.at(-1)
    }
  end

  def read_problems_part2(file) do
    rows =
      file
      |> File.stream!()
      |> Stream.map(fn s -> String.trim_trailing(s, "\n") end)
      |> Enum.to_list()

    {
      rows
      |> Enum.drop(-1)
      |> Stream.map(&String.graphemes/1)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(fn row -> row |> Enum.filter(&(&1 != " ")) |> Enum.join() end)
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.reject(&(&1 == [""]))
      |> Enum.map(fn r -> Enum.map(r, &String.to_integer/1) end),
      rows
      |> Enum.at(-1)
      |> String.split(~r{\s}, trim: true)
    }
  end

  def handle_problem(p, "*") do
    Enum.reduce(p, 1, fn x, acc -> x * acc end)
  end

  def handle_problem(p, "+") do
    Enum.reduce(p, 0, fn x, acc -> x + acc end)
  end

  def handle_problems({problems, operators}) do
    Enum.zip(problems, operators)
    |> Enum.map(fn {p, o} -> handle_problem(p, o) end)
  end

  def part1 do
    "inputs/day06.txt"
    |> read_problems_part1()
    |> handle_problems()
    |> Enum.sum()
  end

  def part2 do
    "inputs/day06.txt"
    |> read_problems_part2()
    |> handle_problems()
    |> Enum.sum()
  end
end
