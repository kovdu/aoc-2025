defmodule Day09Test do
  use ExUnit.Case

  test "edge_intersect" do
    rectangle_edges =
      Day09.generate_rectangles([{9, 5}, {2, 3}]) |> Enum.at(0) |> Day09.rectangle_to_edges()

    polygon_edges =
      "inputs/day09_sample.txt"
      |> Day09.read_positions()
      |> Day09.generate_edges_polygon()

    assert rectangle_edges
           |> Enum.any?(fn edge -> Enum.any?(polygon_edges, &Day09.edge_intersect(edge, &1)) end) ==
             false
  end
end
