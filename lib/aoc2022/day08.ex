defmodule Aoc2022.Day08 do

  defp format(input) do
    input
      |> String.split("", trim: true)
      |> Enum.chunk_by(& &1 == "\n")
      |> Enum.reject(& &1 == ["\n"])
      |> Enum.map(& Enum.map(&1, fn s -> String.to_integer(s) end))
  end

  defp bounds(map) do
    w = Enum.count(Enum.at(map, 0))
    h = Enum.count(map)
    {0, 0, w - 1, h - 1}
  end

  defp height(map, {x, y}) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp scan(map, range, :x, y) do
    range
      |> Enum.map(& height(map, {&1, y}))
      |> Enum.max()
  end

  defp scan(map, range, :y, x) do
    range
      |> Enum.map(& height(map, {x, &1}))
      |> Enum.max()
  end

  defp visible?(map, {x, y}) do
    {xmin, ymin, xmax, ymax} = bounds(map)

    if x == xmin or x == xmax or y == ymin or y == ymax do
      true
    else
      h = height(map, {x, y})

      l = scan(map, xmin..(x-1), :x, y)
      r = scan(map, (x+1)..xmax, :x, y)

      t = scan(map, ymin..(y-1), :y, x)
      b = scan(map, (y+1)..ymax, :y, x)

      l < h or r < h or t < h or b < h
    end
  end

  defp search(map) do
    {xmin, ymin, xmax, ymax} = bounds(map)

    (for x <- xmin..xmax, y <- ymin..ymax, do: {x, y})
      |> Enum.map(& if (visible?(map, &1)), do: 1, else: 0)
      |> Enum.sum()
  end

  def part_one(input) do
    input
      |> format
      |> search
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp scan_visible(map, range, :x, y),
    do: _scan_visible(Enum.map(range, & height(map, {&1, y})))

  defp scan_visible(map, range, x, :y),
    do: _scan_visible(Enum.map(range, & height(map, {x, &1})))

  defp _scan_visible([tree | range]) do
    Enum.reduce_while(range, 0, fn other_tree, acc ->
      if other_tree < tree,
        do: {:cont, acc + 1},
      else: {:halt, acc + 1}
    end)
  end

  defp scenic_score(map, {x, y}) do
    {xmin, ymin, xmax, ymax} = bounds(map)

    directions = [
      {y..ymin, x, :y},
      {y..ymax, x, :y},
      {x..xmin, :x, y},
      {x..xmax, :x, y},
    ]

    directions
      |> Enum.map(fn {r, x, y} -> scan_visible(map, r, x, y) end)
      |> Enum.product()
  end

  defp search2(map) do
    {xmin, ymin, xmax, ymax} = bounds(map)

    (for x <- xmin..xmax, y <- ymin..ymax, do: scenic_score(map, {x, y}))
      |> Enum.max()
  end

  def part_two(input) do
    input
      |> format
      |> search2
  end

end
