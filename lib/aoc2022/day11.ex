defmodule Aoc2022.Day11 do

  defp format(input) do
    input
      |> String.split(~r/\R\R/)
  end

  defmodule Monkey do
    defstruct [
      :monkey_id,
      :worry_levels,
      :worry_change,
      :test,
      :test_throw_true,
      :test_throw_false,
    ]

    defp extract(input, regex, apply \\ nil) do
      case Regex.run(regex, input, capture: :all_but_first) do
        [v] -> if apply != nil, do: apply.(v), else: v
        [ ] -> nil
      end
    end

    def new(input) do
      fmt_worry_levels = fn str ->
        str
          |> String.split(", ")
          |> Enum.map(&String.to_integer/1)
      end

      %__MODULE__{
        monkey_id:        extract(input, ~r/Monkey (\d{1,})/, &String.to_integer/1),
        worry_levels:     extract(input, ~r/Starting items: (.*)/, fmt_worry_levels),
        worry_change:     extract(input, ~r/Operation: new = (.*)/),
        test:             extract(input, ~r/Test: (.*)/),
        test_throw_true:  extract(input, ~r/If true: throw to monkey (\d{1,})/, &String.to_integer/1),
        test_throw_false: extract(input, ~r/If false: throw to monkey (\d{1,})/, &String.to_integer/1),
      }
    end
  end

  defp play(monkeys) do
    IO.inspect monkeys
    Enum.reduce(monkeys, monkeys, fn monkey, all ->

      IO.puts "Monkey " <> to_string(monkey.monkey_id) <> ":"

      # Inspect and throw item.
      Enum.reduce(monkey.worry_levels, monkeys, fn worry, all ->
        IO.puts "  Monkey inspects an item with a worry level of " <> to_string(worry)
        #IO.puts "    Worry level is multiplied by "

        worry = calculate_worry_level(monkey, worry)
        throw = calculate_throw_target(monkey, worry)

        IO.puts "    Item with worry level " <> to_string(worry) <> " is thrown to monkey " <> to_string(throw) <> "."

        all
      end)
    end)
  end

  defp calculate_worry_level(monkey, worry) do
    worry_string = monkey.worry_change
      |> String.replace("old", to_string(worry))
      |> String.replace(" ", "")

    worry = case Regex.run(~r/(\d{1,})(.)(\d{1,})/, worry_string, capture: :all_but_first) do
      [a, "+", b] -> String.to_integer(a) + String.to_integer(b)
      [a, "*", b] -> String.to_integer(a) * String.to_integer(b)
    end

    IO.puts "    Worry level is increased to " <> to_string(worry)

    worry = div(worry, 3)

    IO.puts "    Monkey gets bored with item. Worry level is divided by 3 to " <> to_string(worry) <> "."

    worry
  end

  defp calculate_throw_target(monkey, worry) do
    divisor = Regex.run(~r/divisible by (\d{1,})/, monkey.test, capture: :all_but_first)
      |> List.first()
      |> String.to_integer()

    IO.puts if rem(worry, divisor) == 0,
      do: "    Current worry level is divisible by " <> to_string(divisor),
    else: "    Current worry level is not divisible by " <> to_string(divisor)

    if rem(worry, divisor) == 0,
      do: monkey.test_throw_true,
    else: monkey.test_throw_false
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    input
      |> format
      |> Enum.map(&Monkey.new/1)
      |> play
      |> IO.inspect(charlists: :as_lists)
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end
end
