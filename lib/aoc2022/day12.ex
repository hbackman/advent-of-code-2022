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

  defp find_position(%Matrix{data: data}, target) do
    Enum.find_value(data, fn {y, row} ->
      Enum.find_value(row, fn {x, val} ->
        if val == target,
          do: {x, y},
        else: nil
      end)
    end)
  end

  defp neighbors(map, {x, y}) do
     [
      {x, y-1},
      {x, y+1},
      {x-1, y},
      {x+1, y},
    ] |> Enum.map(fn pos ->
        {pos, Matrix.get(map, pos)}
      end)
      |> Enum.filter(& elem(&1, 1))
      |> Enum.filter(fn {_, val} ->
        case char_diff(val, Matrix.get(map, x, y)) do
          0 -> true
          1 -> true
          _ -> false
        end
      end)
      |> Enum.map(& elem(&1, 0))
  end

  defp char_diff(a, b)
    when byte_size(a) == 1
     and byte_size(b) == 1
  do
    a = a |> to_charlist |> hd 
    b = b |> to_charlist |> hd
    a - b
  end

  defp search(map, spos, epos) do
    graph = :digraph.new()

    IO.inspect {spos, epos}

    wr = 0..(map.w-1)
    hr = 0..(map.h-1)

    # Add vertices.
    for x <- wr, y <- hr do
      :digraph.add_vertex(graph, {x, y})
    end

    # Add edges.
    for x <- wr, y <- hr do
      Enum.each(neighbors(map, {x, y}), fn pos ->
        :digraph.add_edge(graph, {x, y}, pos)
      end)
    end

    case :digraph.get_short_path(graph, spos, epos) do
      false -> :not_found
      path  -> length(path) - 1
    end
  end

  defp search({map, spos, epos}),
    do: search(map, spos, epos)

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    IO.inspect input
      |> format()
      |> search()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end
end
