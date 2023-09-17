defmodule Aoc2022.Day12 do

  defp format(input) do
    map = input
      |> String.split("", trim: true)
      |> Enum.chunk_by(& &1 == "\n")
      |> Enum.reject(& &1 == ["\n"])
      |> Matrix.from_list()

    {spos, map} = replace_symbol(map, "S", "a")
    {epos, map} = replace_symbol(map, "E", "z")

    {spos, epos, map}
  end

  defp replace_symbol(map, sym1, sym2) do
    {nil, map}
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    input
      |> format()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end
end
