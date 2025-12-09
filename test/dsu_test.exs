defmodule DSUTest do
  use ExUnit.Case

  test "DSU.new" do
    grid = DSU.new(0..4)
    assert grid.parent == %{0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4}
    assert grid.size == %{0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1}
  end

  test "DSU.union" do
    grid = DSU.new(0..4)
    grid = DSU.union(grid, 0, 1)
    assert grid.parent == %{0 => 0, 1 => 0, 2 => 2, 3 => 3, 4 => 4}
    assert grid.size == %{0 => 2, 1 => 0, 2 => 1, 3 => 1, 4 => 1}

    grid = DSU.union(grid, 1, 4)
    assert grid.parent == %{0 => 0, 1 => 0, 2 => 2, 3 => 3, 4 => 0}
    assert grid.size == %{0 => 3, 1 => 0, 2 => 1, 3 => 1, 4 => 0}
  end

  test "DSU.get_sizes" do
    grid = DSU.new(0..4)
    assert DSU.get_sizes(grid) == [{0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}]
    grid = DSU.union(grid, 0, 1)
    grid = DSU.union(grid, 1, 4)
    assert DSU.get_sizes(grid) == [{0, 3}, {2, 1}, {3, 1}]

    grid = DSU.union(grid, 0, 4)
    assert DSU.get_sizes(grid) == [{0, 3}, {2, 1}, {3, 1}]
  end

  test "DSU.find" do
    grid = DSU.new(0..4)
    assert DSU.find(grid, 0) == {grid, 0}
    assert DSU.find(grid, 1) == {grid, 1}
    assert DSU.find(grid, 2) == {grid, 2}
    assert DSU.find(grid, 3) == {grid, 3}
    assert DSU.find(grid, 4) == {grid, 4}

    grid = DSU.union(grid, 0, 1)
    grid = DSU.union(grid, 1, 2)
    assert DSU.find(grid, 0) == {grid, 0}
    assert DSU.find(grid, 1) == {grid, 0}
    assert DSU.find(grid, 2) == {grid, 0}
    assert DSU.find(grid, 3) == {grid, 3}
    assert DSU.find(grid, 4) == {grid, 4}
  end
end
