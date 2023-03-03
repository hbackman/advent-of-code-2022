defmodule Aoc2022.Day08 do
  
  defp format(input) do
    input
      |> String.split("", trim: true)
      |> Enum.chunk_by(& &1 == "\n")
      |> Enum.reject(& &1 == ["\n"])
      |> Enum.map(& Enum.map(&1, fn s -> String.to_integer(s) end))
  end

  defp size(map), do: {
    Enum.count(Enum.at(map, 0)),
    Enum.count(map),
  }

  defp height(map, {x, y}) do
    map
      |> Enum.at(y)
      |> Enum.at(x)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  # Check if a position is inside the map.
  defp inside?(map, {x, y}) do
    {xlen, ylen} = size(map)

    (y >= 1 and y < xlen-1) and
    (x >= 1 and x < ylen-1)
  end

  defp ray(map, :x, y, range) do
    {xlen, _} = size(map)
    {_, data} = Enum.reduce(range, {0, []}, fn x, {current, visible} ->
      height = height(map, {x, y})
      {
        max(height, current),
        if height > current do
          [{x, y} | visible]
        else
          visible
        end
      }
    end)
    data
  end

  defp ray(map, :y, x, range) do
    {_, ylen} = size(map)
    {_, data} = Enum.reduce(range, {0, []}, fn y, {current, visible} ->
      height = height(map, {x, y})
      {
        max(height, current),
        if height > current do
          [{x, y} | visible]
        else
          visible
        end
      }
    end)
    data
  end

  # Search the map for all visible trees.
  defp search(map) do
    {xlen, ylen} = size(map)

    Enum.map(1..(ylen-2), & ray(map, :x, &1, 0..(xlen-1))) ++ # Left -> Right
    Enum.map(1..(xlen-2), & ray(map, :y, &1, 0..(ylen-1))) ++ # Top -> Bottom
    Enum.map(1..(ylen-2), & ray(map, :x, &1, (xlen-1)..0)) ++ # Right -> Left
    Enum.map(1..(xlen-2), & ray(map, :y, &1, (ylen-1)..0))    # Bottom -> Top
      |> List.flatten()
      |> Enum.uniq()
      |> Enum.filter(& inside?(map, &1))
  end

  def part_one(input) do
    input
      |> format
      |> search
      |> Enum.count()
  end
  
  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------
  
  def part_two(input) do
    input
  end
    
end