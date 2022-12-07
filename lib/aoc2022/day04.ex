defmodule Aoc2022.Day04 do

  defp fmt_number(items) do
    Enum.map(items, &String.to_integer/1)
  end

  defp fmt_record([x1, y1, x2, y2]) do
    [{x1, y1}, {x2, y2}]
  end

  defp format(input) do
    Regex.scan(~r/(\d*)-(\d*).(\d*)-(\d*)/, input, capture: :all_but_first)
      |> Enum.map(&fmt_number/1)
      |> Enum.map(&fmt_record/1)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp contained?([{x1, y1}, {x2, y2}]) do
    (x1 >= x2 && y1 <= y2) ||
    (x2 >= x1 && y2 <= y1)
  end

  def part_one(input) do
    input
      |> format
      |> Enum.filter(&contained?/1)
      |> Enum.count()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp intersects?([{x1, y1}, {x2, y2}]) do
    y1 >= x2 && y2 >= x1
  end

  def part_two(input) do
    input
      |> format
      |> Enum.filter(&intersects?/1)
      |> Enum.count()
  end

end
