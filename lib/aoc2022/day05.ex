defmodule Aoc2022.Day05 do

  defp init_view(view) do
    {map, leg} = String.split(view, ~r/\R/)
      |> Enum.split(-1)

    len = leg
      |> List.first
      |> String.replace(" ", "")
      |> String.length

    Enum.reduce(1..len, %{}, fn idx, acc ->
      Map.put(acc, idx, map
        |> Enum.reduce([], & &2 ++ [String.at(&1, 1+4*(idx-1))])
        |> Enum.filter(& &1 && &1 != " "))
    end)
  end

  defp draw_view(view) do
    Enum.each(view, fn {idx, crates} ->
      IO.write idx
      IO.write " "

      crates
        |> Enum.reverse()
        |> Enum.each(& IO.write &1)

      IO.puts ""
    end)
    IO.puts "---------"

    view
  end

  defp init_inst(inst) do
    Regex.scan(~r/(\d).*(\d).*(\d)/, inst, capture: :all_but_first)
  end

  defp format(input) do
    [view, inst] = String.split(input, ~r/\R\R/)
    {
      init_view(view),
      init_inst(inst),
    }
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp move(view, f, t) do
    crate = List.first(view[f])

    if crate do
      view
        |> Map.put(t, [crate | view[t]])
        |> Map.put(f, Enum.drop(view[f], 1))
    else
      IO.inspect "CRATE MISSING"
      IO.inspect [f, t]
      IO.inspect view
    end
  end

  defp handle({ view, [] }), do: view

  defp handle({ view, [inst | tail] }) do
    [n, f, t] = inst
      |> Enum.map(&String.to_integer/1)

    IO.inspect view

    view = Enum.reduce(1..n, view, fn _, acc ->
      move(acc, f, t)
    end)

    handle({ view, tail })
  end

  def part_one(input) do
    input
      |> format
      |> handle
      #|> Enum.map(fn {_, list} -> List.first(list) end)
      #|> Enum.join()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end

end
