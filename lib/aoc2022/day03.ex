defmodule Aoc2022.Day03 do

  @alphabet [
    "abcdefghijklmnopqrstuvwxyz",
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    |> Enum.join()
    |> String.graphemes()

  defp fmt(input) do
    input
      |> String.split(~r/\R/)
      |> Enum.map(&String.graphemes/1)
  end

  # Intersect multiple
  defp intersect([ a, b | t ]) do
    intersect([ intersect(a, b) | t ])
  end

  # Recursive return
  defp intersect([ a ]), do: a

  # Intersect two
  defp intersect({a, b}), do: intersect(a, b)
  defp intersect(a, b) do
    MapSet.intersection(
      MapSet.new(a),
      MapSet.new(b))
      |> MapSet.to_list
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp partition(items) do
    Enum.split(items, round(length(items) / 2))
  end

  defp get_shared(items) do
    items
      |> partition
      |> intersect
  end

  defp get_value(item) do
    Enum.find_index(@alphabet, & &1 == item) + 1
  end

  def part_one(input) do
    input
      |> fmt
      |> Enum.map(&get_shared/1)
      |> List.flatten()
      |> Enum.map(&get_value/1)
      |> Enum.sum()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
      |> fmt
      |> Enum.chunk_every(3)
      |> Enum.map(&intersect/1)
      |> List.flatten()
      |> Enum.map(&get_value/1)
      |> Enum.sum()
  end

end
