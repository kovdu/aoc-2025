defmodule Day04 do
  defp neighbors({x, y}) do
    for i <- -1..1, j <- -1..1, {i, j} != {0, 0}, do: {x + i, y + j}
  end

  def read_grid(file) do
    values =
      file
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.map(fn s -> String.graphemes(s) end)

    Enum.reduce(Enum.with_index(values), %{}, fn {row, y}, grid ->
      Enum.reduce(Enum.with_index(row), grid, fn {v, x}, acc ->
        Map.put(acc, {x, y}, v)
      end)
    end)
  end

  def count_rolls_of_paper(grid) do
    grid
    |> Enum.filter(fn {_pos, v} -> v == "@" end)
    |> Enum.map(fn {pos, _v} ->
      count =
        pos
        |> neighbors()
        |> Enum.count(&(Map.get(grid, &1) == "@"))

      {pos, count}
    end)
    |> Map.new()
  end

  def clear_grid_once(grid) do
    positions_to_clear =
      grid
      |> count_rolls_of_paper()
      |> Enum.filter(fn {_pos, v} -> v < 4 end)

    grid =
      Enum.reduce(positions_to_clear, grid, fn {{x, y}, _v}, acc ->
        Map.delete(acc, {x, y})
      end)

    {positions_to_clear |> Enum.count(), grid}
  end

  def clear_grid(grid) do
    {count, grid} = clear_grid_once(grid)

    if count == 0 do
      {0, grid}
    else
      {c, g} = clear_grid(grid)
      {c + count, g}
    end
  end

  def part1 do
    "inputs/day04.txt"
    |> read_grid()
    |> count_rolls_of_paper()
    |> Enum.count(fn {_pos, v} -> v < 4 end)
  end

  def part2 do
    "inputs/day04.txt"
    |> read_grid()
    |> clear_grid()
    |> elem(0)
  end
end
