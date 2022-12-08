defmodule Aoc2022.Day06 do

  defp scan_packet(buffer, size, index \\ 0) do
    packet = Enum.take(buffer, size)
    unique = packet
      |> Enum.uniq()
      |> Enum.count() == size

    if unique do
      index + size
    else
      scan_packet(Enum.drop(buffer, 1), size, index + 1)
    end
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    input
      |> String.graphemes
      |> scan_packet(4)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
      |> String.graphemes
      |> scan_packet(14)
  end
  
end