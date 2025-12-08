defmodule Day07 do
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

  def find_splitter(grid, {x, y} = pos, splitters) do
    case Map.get(grid, pos) do
      "^" ->
        if MapSet.member?(splitters, pos) do
          splitters
        else
          splitters = MapSet.put(splitters, pos)
          splitters = find_splitter(grid, {x + 1, y + 1}, splitters)
          find_splitter(grid, {x - 1, y + 1}, splitters)
        end

      "." ->
        find_splitter(grid, {x, y + 1}, splitters)

      "S" ->
        find_splitter(grid, {x, y + 1}, splitters)

      _ ->
        splitters
    end
  end

  def count_path(grid, {x, y} = pos, grid_count) do
    if Map.has_key?(grid_count, pos) do
      {Map.get(grid_count, pos), grid_count}
    else
      {c, grid_count} =
        case Map.get(grid, pos) do
          "^" ->
            {l, grid_count} = count_path(grid, {x + 1, y + 1}, grid_count)
            {r, grid_count} = count_path(grid, {x - 1, y + 1}, grid_count)
            {l + r, grid_count}

          "." ->
            count_path(grid, {x, y + 1}, grid_count)

          "S" ->
            count_path(grid, {x, y + 1}, grid_count)

          nil ->
            {1, grid_count}
        end

      {c, Map.put(grid_count, pos, c)}
    end
  end

  def get_start(grid) do
    grid
    |> Enum.filter(fn {_pos, v} -> v == "S" end)
    |> Enum.map(fn {pos, _v} -> pos end)
    |> Enum.at(0)
  end

  def part1 do
    grid = read_grid("inputs/day07.txt")

    splitters = find_splitter(grid, grid |> get_start(), MapSet.new())
    splitters |> Enum.count()
  end

  def part2 do
    grid = read_grid("inputs/day07.txt")

    {count, _cache} = count_path(grid, grid |> get_start(), %{})
    count
  end
end
