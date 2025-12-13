defmodule Day11 do
  def read_paths(file) do
    file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn s -> String.split(s, ":") end)
    |> Stream.map(fn [x, y] ->
      {String.trim(x), y |> String.split(~r{\s}, trim: true)}
    end)
    |> Enum.to_list()
    |> Map.new()
  end

  def revert_paths(paths) do
    paths
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Enum.reduce(v, acc, fn x, acc ->
        Map.update(acc, x, [k], fn l -> [k | l] end)
      end)
    end)
  end

  def count_paths(paths, node, target, visited \\ MapSet.new(), found_paths \\ %{}) do
    if node == target do
      {1, found_paths}
    else
      if Map.has_key?(found_paths, node) do
        {found_paths[node], found_paths}
      else
        case Map.get(paths, node) do
          nil ->
            {0, found_paths}

          l ->
            {count, found_paths} =
              Enum.reduce(l, {0, found_paths}, fn x, {acc, found_paths} ->
                if MapSet.member?(visited, x) do
                  {acc, found_paths}
                else
                  {path_count, found_paths} =
                    count_paths(paths, x, target, MapSet.put(visited, x), found_paths)

                  {acc + path_count, found_paths}
                end
              end)

            {count, Map.put(found_paths, node, count)}
        end
      end
    end
  end

  def both_dac_fft(paths) do
    {c1, _} = count_paths(paths, "svr", "fft")
    {c2, _} = count_paths(paths, "fft", "dac")
    {c3, _} = count_paths(paths, "dac", "out")
    c1 * c2 * c3
  end

  def part1 do
    "inputs/day11.txt"
    |> read_paths()
    |> revert_paths()
    |> count_paths("out", "you")
  end

  def part2 do
    "inputs/day11.txt"
    |> read_paths()
    |> both_dac_fft()
  end
end
