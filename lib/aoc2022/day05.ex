defmodule Aoc2022.Day05 do

  defp init_config(string) do
    {map, leg} = String.split(string, ~r/\R/)
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

  defp init_inst(inst) do
    Regex.scan(~r/(\d+).*(\d+).*(\d+)/, inst, capture: :all_but_first)
  end

  defp format(input) do
    [config, instructions] = String.split(input, ~r/\R\R/)
    {
      init_config(config),
      init_inst(instructions),
    }
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp arrange(config, count, f, t) do
    crates = Enum.take(config[f], count)
      |> Enum.reverse()
    config
      |> Map.put(t, crates ++ config[t])
      |> Map.put(f, Enum.drop(config[f], count))
  end

  defp handle({ config, [] }, _), do: config

  defp handle({ config, [i | instructions] }, func) do
    [n, f, t] = Enum.map(i, &String.to_integer/1)

    config = func.(config, n, f, t)

    handle({ config, instructions }, func)
  end

  def part_one(input) do
    input
      |> format
      |> handle(&arrange/4)
      |> Enum.map(fn {_, list} -> List.first(list) end)
      |> Enum.join()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp arrange2(config, count, f, t) do
    crates = Enum.take(config[f], count)
    config
    |> Map.put(t, crates ++ config[t])
    |> Map.put(f, Enum.drop(config[f], count))
  end

  def part_two(input) do
    input
      |> format
      |> handle(&arrange2/4)
      |> Enum.map(fn {_, list} -> List.first(list) end)
      |> Enum.join()
  end

end
