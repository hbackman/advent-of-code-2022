defmodule Aoc2022.Day01 do

  defp fmt(input) do
    input
      |> String.split(~r/\R\R/)
      |> Enum.map(fn group ->
        group
          |> String.split(~r/\R/)
          |> Enum.map(& String.to_integer(&1))
      end)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one (input) do
    input
      |> fmt
      |> Enum.map(& Enum.sum(&1))
      |> Enum.max()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two (input) do
    input
      |> fmt
      |> Enum.map(& Enum.sum(&1))
      |> Enum.sort(&(&1 >= &2))
      |> Enum.take(3)
      |> Enum.sum()
  end

end
