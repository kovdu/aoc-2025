defmodule Day08 do
  def read_positions(file) do
    file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn s -> String.split(s, ",") end)
    |> Stream.map(fn [x, y, z] ->
      {String.to_integer(x), String.to_integer(y), String.to_integer(z)}
    end)
    |> Enum.to_list()
  end

  def distance({x1, y1, z1}, {x2, y2, z2}) do
    Integer.pow(x1 - x2, 2) + Integer.pow(y1 - y2, 2) + Integer.pow(z1 - z2, 2)
  end

  def find_and_sort_all_distances(positions) do
    for(
      {p1, i1} <- Enum.with_index(positions),
      {p2, i2} <- Enum.with_index(positions),
      i1 < i2,
      do: {distance(p1, p2), p1, p2, i1, i2}
    )
    |> Enum.sort_by(fn {dist, _p1, _p2, _i1, _i2} -> dist end)
  end

  def connect(positions, number_of_connections) do
    positions
    |> find_and_sort_all_distances()
    |> Enum.take(number_of_connections)
    |> Enum.reduce(DSU.new(0..(length(positions) - 1)), fn {_, _, _, i1, i2}, dsu ->
      DSU.union(dsu, i1, i2)
    end)
  end

  def multiply_size_of_largest_circuits(dsu, count) do
    dsu
    |> DSU.get_sizes()
    |> Enum.sort_by(fn {_root, sz} -> -sz end)
    |> Enum.take(count)
    |> Enum.map(fn {_root, sz} -> sz end)
    |> Enum.product()
  end

  def add_points_until_one_set(dsu, positions) do
    case positions do
      [] ->
        nil

      [{_dist, _p1, _p2, i1, i2} | t] ->
        dsu = DSU.union(dsu, i1, i2)

        if DSU.get_sizes(dsu) |> Enum.count() == 1 do
          {i1, i2}
        else
          add_points_until_one_set(dsu, t)
        end
    end
  end

  def connect_until_one_set(positions) do
    distances =
      positions
      |> find_and_sort_all_distances()

    dsu = DSU.new(0..(length(positions) - 1))

    {positions, add_points_until_one_set(dsu, distances)}
  end

  def multiply_x_positions({positions, {i1, i2}}) do
    {x1, _, _} = Enum.at(positions, i1)
    {x2, _, _} = Enum.at(positions, i2)
    x1 * x2
  end

  def part1 do
    "inputs/day08.txt"
    |> read_positions()
    |> connect(1000)
    |> multiply_size_of_largest_circuits(3)
  end

  def part2 do
    "inputs/day08.txt"
    |> read_positions()
    |> connect_until_one_set()
    |> multiply_x_positions()
  end
end
