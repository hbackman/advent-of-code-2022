defmodule Aoc2022.Day12 do

  defp format(input) do
    map = input
      |> String.split("", trim: true)
      |> Enum.chunk_by(& &1 == "\n")
      |> Enum.reject(& &1 == ["\n"])
      |> Matrix.from_list()

    {spos, map} = swap_symbol(map, "S", "a")
    {epos, map} = swap_symbol(map, "E", "z")

    {map, spos, epos}
  end

  defp swap_symbol(map, sym1, sym2) do
    pos = find_position(map, sym1)
    map = Matrix.put(map, pos, sym2)

    {pos, map}
  end

  defp print(map) do
    IO.puts map
      |> Enum.map(& Enum.join(&1, ""))
      |> Enum.join("\n")
  end

  defp search(map, pos, epos, visited \\ []) do
    if pos == epos do
      {:found, visited}
    else
      neighbors(map, pos, visited)
        |> Enum.map(fn next_pos ->
          search(map, next_pos, epos, [pos | visited])
        end)
        |> List.flatten()
    end
  end

  defp search({map, spos, epos}),
    do: search(map, spos, epos)

  defp find_position(%Matrix{data: data}, target) do
    Enum.find_value(data, fn {y, row} ->
      Enum.find_value(row, fn {x, val} ->
        if val == target,
          do: {x, y},
        else: nil
      end)
    end)
  end

  defp neighbors(map, {x, y}, except \\ []) do
    directions = [
      {x, y-1},
      {x, y+1},
      {x-1, y},
      {x+1, y},
    ] |> Enum.map(fn pos ->
        {pos, Matrix.get(map, pos)}
      end)
      |> Enum.filter(& elem(&1, 1))
      |> Enum.filter(fn {pos, val} ->
        case char_diff(val, Matrix.get(map, x, y)) do
          0 -> true
          1 -> true
          _ -> false
        end
      end)
      |> Enum.map(& elem(&1, 0))
      |> Enum.filter(& Enum.member?(except, &1) == false)
  end

  defp char_diff(a, b)
    when byte_size(a) == 1
     and byte_size(b) == 1
  do
    a = a |> to_charlist |> hd 
    b = b |> to_charlist |> hd
    a - b
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    IO.inspect input
      |> format()
      |> search()
      |> Enum.map(fn {:found, path} ->
        Enum.count(path)
      end)
      |> Enum.min()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end
end
