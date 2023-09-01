defmodule Aoc2022.Day10 do

  defp format(input) do
    Regex.scan(~r/(\w{1,}) ?(-?\d{1,})?/, input, capture: :all_but_first)
      |> Enum.map(fn
        [op]     -> {op, nil}
        [op, ag] -> {op, String.to_integer(ag)}
      end)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp execute({clk, reg}, "noop", nil) do
    [{clk + 1, reg}]
  end

  defp execute({clk, reg}, "addx", value) do
    [
      {clk + 1, reg},
      {clk + 2, reg + value},
    ] |> Enum.reverse()
  end

  def part_one(input) do
    signal = [
      20, 60, 100, 140, 180, 220,
    ]
    input
      |> format
      |> Enum.reduce([{1, 1}], fn {op, v}, state ->
        execute(hd(state), op, v) ++ state
      end)
      |> Enum.filter(fn {clk, reg} -> Enum.member?(siglist, clk) end)
      |> Enum.reduce(0, fn {clk, reg}, acc -> acc + clk * reg end)
  end
end