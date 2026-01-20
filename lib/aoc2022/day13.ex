defmodule Aoc2022.Day13 do

  defp format(input) do
    String.split(input, ~r/\R/)
      |> Enum.reject(& &1 == "")
      |> Enum.map(&format_packet/1)
      |> Enum.chunk_every(2)
  end

  defp format_packet(packet) do
    {result, _binding} = Code.eval_string(packet)
    result
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    input
      |> format
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end
end
