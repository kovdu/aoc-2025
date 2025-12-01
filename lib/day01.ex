defmodule Day01 do
  def read_sequences(file) do
    file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split_at(&1, 1))
    |> Stream.map(fn {dir, dist} -> {dir, String.to_integer(dist)} end)
    |> Enum.to_list()
  end

  def count_zeros(sequence, start, size) do
    Enum.reduce(sequence, {0, start}, fn {dir, dist}, {count, position} ->
      new_position =
        Integer.mod(
          case dir do
            "R" -> position + dist
            "L" -> position - dist
          end,
          size
        )

      {if(new_position == 0, do: count + 1, else: count), new_position}
    end)
  end

  def part1 do
    sequence = read_sequences("inputs/day01.txt")
    count_zeros(sequence, 50, 100)
  end

  def count_wraps(sequence, start, size) do
    Enum.reduce(sequence, {0, start}, fn {dir, dist}, {count, position} ->
      mod_distance = Integer.mod(dist, size)

      new_position =
        case dir do
          "R" -> position + mod_distance
          "L" -> position - mod_distance
        end

      wrap_count =
        if (position != 0 && new_position <= 0) || new_position >= size do
          1 + div(dist, size)
        else
          div(dist, size)
        end

      new_position = Integer.mod(new_position, size)

      {count + wrap_count, Integer.mod(new_position, size)}
    end)
  end

  def part2 do
    sequence = read_sequences("inputs/day01.txt")
    count_wraps(sequence, 50, 100)
  end
end
