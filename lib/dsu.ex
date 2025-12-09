defmodule DSU do
  def new(items) do
    parent = Map.new(items, &{&1, &1})
    size = Map.new(items, &{&1, 1})
    %{parent: parent, size: size}
  end

  def find(dsu, x) do
    if dsu.parent[x] == x do
      {dsu, x}
    else
      {dsu2, root} = find(dsu, dsu.parent[x])
      {put_in(dsu2.parent[x], root), root}
    end
  end

  def union(dsu, a, b) do
    {dsu, ra} = find(dsu, a)
    {dsu, rb} = find(dsu, b)

    if ra == rb do
      dsu
    else
      dsu
      |> put_in([:parent, rb], ra)
      |> update_in([:size, ra], &(&1 + dsu.size[rb]))
      # size no longer used
      |> put_in([:size, rb], 0)
    end
  end

  # sizes of each existing set
  def get_sizes(dsu) do
    dsu.size
    # only root sizes > 0
    |> Enum.filter(fn {_root, sz} -> sz > 0 end)
  end
end
