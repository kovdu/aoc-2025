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

  def generate_rectangles(positions) do
    for(
      {p1, i1} <- Enum.with_index(positions),
      {p2, i2} <- Enum.with_index(positions),
      i1 < i2
    ) do
      minx = min(elem(p1, 0), elem(p2, 0))
      maxx = max(elem(p1, 0), elem(p2, 0))
      miny = min(elem(p1, 1), elem(p2, 1))
      maxy = max(elem(p1, 1), elem(p2, 1))

      {
        # top-left
        {minx, miny},
        # top-right
        {maxx, miny},
        # bottom-left
        {minx, maxy},
        # bottom-right
        {maxx, maxy}
      }
    end
  end

  def rectangle_to_edges({{x1, y1}, {x2, y2}, {x3, y3}, {x4, y4}}) do
    [
      # top edge (top-left to top-right)
      {{x1, y1}, {x2, y2}},
      # right edge (top-right to bottom-right)
      {{x2, y2}, {x4, y4}},
      # bottom edge (bottom-right to bottom-left)
      {{x4, y4}, {x3, y3}},
      # left edge (bottom-left to top-left)
      {{x3, y3}, {x1, y1}}
    ]
  end

  def is_on_segment?({p_x, p_y}, {vi_x, vi_y}, {vj_x, vj_y}) do
    is_collinear = vi_x == vj_x or vi_y == vj_y

    is_contained =
      p_x >= min(vi_x, vj_x) and p_x <= max(vi_x, vj_x) and
        p_y >= min(vi_y, vj_y) and p_y <= max(vi_y, vj_y)

    is_collinear and is_contained
  end

  def point_in_polygon?({p_x, p_y}, polygon) do
    if Enum.any?(polygon, fn {v1, v2} -> is_on_segment?({p_x, p_y}, v1, v2) end) do
      true
    else
      intersection_count =
        Enum.reduce(polygon, 0, fn {{vi_x, vi_y}, {_, vj_y}}, acc ->
          if vi_y == vj_y do
            acc
          else
            # Vertical Span Check: Is P_y strictly between vi_y and vj_y?
            is_crossing_y = vi_y > p_y != vj_y > p_y

            # X-Coordinate Check: Is the edge to the right of the point P?
            # Since vi_x == vj_x
            is_to_the_right = vi_x > p_x

            if is_crossing_y and is_to_the_right do
              acc + 1
            else
              acc
            end
          end
        end)

      # even- odd Rule
      rem(intersection_count, 2) == 1
    end
  end

  def edge_intersect({{x1, y1}, {x2, y2}}, {{x3, y3}, {x4, y4}}) do
    cond do
      # Both edges are vertical - no intersection
      x1 == x2 and x3 == x4 ->
        false

      # First edge is vertical, second is horizontal
      x1 == x2 and y3 == y4 ->
        min(x3, x4) < x1 and x1 < max(x3, x4) and
          min(y1, y2) < y3 and y3 < max(y1, y2)

      # Both edges are horizontal - no intersection
      y1 == y2 and y3 == y4 ->
        false

      # First edge is horizontal, second is vertical
      y1 == y2 and x3 == x4 ->
        min(y3, y4) < y1 and y1 < max(y3, y4) and
          min(x1, x2) < x3 and x3 < max(x1, x2)

      # Default case
      true ->
        false
    end
  end

  def generate_edges_polygon(positions) do
    (positions ++ [Enum.at(positions, 0)])
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [{x1, y1}, {x2, y2}] -> {{x1, y1}, {x2, y2}} end)
  end

  def generate_rectangles_inside_polygon(positions) do
    polygon_edges = generate_edges_polygon(positions)

    generate_rectangles(positions)
    |> Enum.filter(fn {p1, p2, p3, p4} ->
      point_in_polygon?(p1, polygon_edges) and
        point_in_polygon?(p2, polygon_edges) and
        point_in_polygon?(p3, polygon_edges) and
        point_in_polygon?(p4, polygon_edges)
    end)
    |> Enum.filter(fn rectangle ->
      edges = rectangle_to_edges(rectangle)
      !Enum.any?(edges, fn edge -> Enum.any?(polygon_edges, &edge_intersect(edge, &1)) end)
    end)
  end

  def find_largest_area(rectangles) do
    rectangles
    |> Enum.map(fn {tl, _, _, br} -> {rectangle_area(tl, br), tl, br} end)
    |> Enum.sort_by(fn {area, _, _} -> -area end)
    |> Enum.at(0)
    |> elem(0)
  end

  def part1 do
    "inputs/day09.txt"
    |> read_positions()
    |> generate_rectangles()
    |> find_largest_area()
  end

  def part2 do
    "inputs/day09.txt"
    |> read_positions()
    |> generate_rectangles_inside_polygon()
    |> find_largest_area()
  end
end
