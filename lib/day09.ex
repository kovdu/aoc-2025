defmodule Day09 do
  def read_positions(file) do
    file
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn s -> String.split(s, ",") end)
    |> Stream.map(fn [x, y] ->
      {String.to_integer(x), String.to_integer(y)}
    end)
    |> Enum.to_list()
  end

  def rectangle_area({x1, y1}, {x2, y2}) do
    (max(x1, x2) - min(x1, x2) + 1) * (max(y1, y2) - min(y1, y2) + 1)
  end

  def find_largest_rectangle(positions) do
    for(
      {p1, i1} <- Enum.with_index(positions),
      {p2, i2} <- Enum.with_index(positions),
      i1 < i2,
      do: {rectangle_area(p1, p2), p1, p2, i1, i2}
    )
    |> Enum.sort_by(fn {area, _p1, _p2, _i1, _i2} -> -area end)
  end

  def part1 do
    "inputs/day09.txt"
    |> read_positions()
    |> find_largest_rectangle()
    |> Enum.at(0)
    |> elem(0)
  end
end
