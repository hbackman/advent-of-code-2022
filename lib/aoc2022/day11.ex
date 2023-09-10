defmodule Aoc2022.Day11 do

  defp format(input) do
    String.split(input, ~r/\R\R/)
  end

  defmodule Monkey do
    defstruct [
      :monkey_id,
      :items,
      :operation,
      :divisible,
      :test_throw_true,
      :test_throw_false,
      throws: 0,
    ]

    defp extract(input, regex, apply \\ nil) do
      case Regex.run(regex, input, capture: :all_but_first) do
        [v] -> if apply != nil, do: apply.(v), else: v
        [ ] -> nil
      end
    end

    def new(input) do
      fmt_items = fn str ->
        str
          |> String.split(", ")
          |> Enum.map(&String.to_integer/1)
      end

      %__MODULE__{
        monkey_id: extract(input, ~r/Monkey (\d{1,})/, &String.to_integer/1),
        items:     extract(input, ~r/Starting items: (.*)/, fmt_items),
        operation: extract(input, ~r/Operation: new = (.*)/),
        divisible: extract(input, ~r/Test: divisible by (.*)/, &String.to_integer/1),
        test_throw_true:  extract(input, ~r/If true: throw to monkey (\d{1,})/, &String.to_integer/1),
        test_throw_false: extract(input, ~r/If false: throw to monkey (\d{1,})/, &String.to_integer/1),
      }
    end
  end

  defp throw_item(monkeys, throw_from, throw_to, item) do
    Enum.map(monkeys, fn
      %{monkey_id: ^throw_from} = monkey -> %{monkey | items: List.delete_at(monkey.items, 0), throws: monkey.throws + 1}
      %{monkey_id: ^throw_to}   = monkey -> %{monkey | items: monkey.items ++ [item]}
      monkey -> monkey
    end)
  end

  defp play(monkeys, relief, turns) do
    modulo = Enum.reduce(monkeys, 1, fn monkey, modulo ->
      modulo * monkey.divisible
    end)

    Enum.reduce(1..turns, monkeys, fn _, monkeys ->
      Enum.reduce(Enum.map(monkeys, & &1.monkey_id), monkeys, fn monkey_id, monkeys ->
        # Find monkey.
        monkey = Enum.find(monkeys, & &1.monkey_id == monkey_id)
  
        # Throw items.
        Enum.reduce(monkey.items, monkeys, fn worry, all ->
          [worry, throw] = calc_throw(monkey, worry, relief, modulo)
  
          throw_item(all, monkey.monkey_id, throw, worry)
        end)
      end)
    end)
  end

  defp calc_throw(monkey, worry, relief, modulo) do
    worry_string = monkey.operation
      |> String.replace("old", to_string(worry))
      |> String.replace(" ", "")

    worry = case Regex.run(~r/(\d{1,})(.)(\d{1,})/, worry_string, capture: :all_but_first) do
      [a, "+", b] -> String.to_integer(a) + String.to_integer(b)
      [a, "*", b] -> String.to_integer(a) * String.to_integer(b)
    end

    worry = div(worry, relief)
    worry = rem(worry, modulo)

    throw = if rem(worry, monkey.divisible) == 0,
      do: monkey.test_throw_true,
    else: monkey.test_throw_false

    [worry, throw]
  end

  defp calc_mbiz(monkeys) do
    monkeys
      |> Enum.map(&(&1.throws))
      |> Enum.sort(&(&1 >= &2))
      |> Enum.take(2)
      |> Enum.product()
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  def part_one(input) do
    input
      |> format
      |> Enum.map(&Monkey.new/1)
      |> play(3, 20)
      |> calc_mbiz()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
      |> format
      |> Enum.map(&Monkey.new/1)
      |> play(1, 10000)
      |> calc_mbiz()
  end
end
