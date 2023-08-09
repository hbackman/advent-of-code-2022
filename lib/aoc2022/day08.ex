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

    visible = (for x <- xmin..xmax, y <- ymin..ymax, do: {x, y})
      |> Enum.map(& if (visible?(map, &1)), do: 1, else: 0)
      |> Enum.sum()

    IO.inspect visible
  end

  def part_one(input) do
    input
      |> format
      |> search
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end

end
