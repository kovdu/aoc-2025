defmodule Day03 do
  def read_joltages(file) do
    file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn s -> String.graphemes(s) end)
    |> Stream.map(fn a -> Enum.map(a, &String.to_integer/1) end)
    |> Enum.to_list()
  end

  def max_joltage({x, y}, batteries) do
    case batteries do
      [a, b | rest] ->
        if a > x do
          max_joltage({a, 0}, [b | rest])
        else
          if a > y do
            max_joltage({x, a}, [b | rest])
          else
            max_joltage({x, y}, [b | rest])
          end
        end

      [a] ->
        if a > y do
          {x, a}
        else
          {x, y}
        end

      [] ->
        {x, y}
    end
  end

  def calculate_max_joltage(batteries) do
    {x, y} = max_joltage({0, 0}, batteries)
    10 * x + y
  end

  # Push number on list and maximize value
  def maximize_joltage(n, l) do
    case l do
      [a | rest] -> if n >= a, do: [n | maximize_joltage(a, rest)], else: l
      [] -> []
    end
  end

  def calculate_max_joltage_for_size(batteries, size) do
    {remaining, on} = Enum.split(batteries, length(batteries) - size)
    Enum.reduce(remaining |> Enum.reverse(), on, fn x, acc -> maximize_joltage(x, acc) end)
    |> Integer.undigits()
  end

  def part1 do
    "inputs/day03.txt"
    |> read_joltages()
    |> Enum.map(fn b -> calculate_max_joltage(b) end)
    |> Enum.sum()
  end

  def part1_alternative do
    "inputs/day03.txt"
    |> read_joltages()
    |> Enum.map(fn b -> calculate_max_joltage_for_size(b, 2) end)
    |> Enum.sum()
  end

  def part2 do
    "inputs/day03.txt"
    |> read_joltages()
    |> Enum.map(fn b -> calculate_max_joltage_for_size(b, 12) end)
    |> Enum.sum()
  end
end
