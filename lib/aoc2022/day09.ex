defmodule Aoc2022.Day09 do

  defp format(input) do
    Regex.scan(~r/(.) (\d*)/, input, capture: :all_but_first)
      |> Enum.map(fn [d, x] ->
        {d, String.to_integer(x)}
      end)
  end

  # Expand the rope movements.
  #   R2,T1,L3 -> RRTLLL
  #
  defp expand(input) do
    Enum.reduce(input, [], fn {dir, amt}, carry ->
      carry ++ List.duplicate(dir, amt)
    end)
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defmodule Rope do
    defstruct [
      head: {0, 0},
      tails: [],
      hist: [],
    ]

    @doc """
    Create a new rope with 'n' number of knots.
    """
    def new(num_tails \\ 1) do
      %Rope{
        head: {0, 0},
        tails: List.duplicate({0, 0}, num_tails),
      }
    end

    @doc """
    Visualize the ropes current position.

    ## Examples:
      iex> Rope.print(%Rope{head: {1, 0}, tail: {0, 0}})
      ......
      ......
      ......
      H.....
      T.....
    """
    def print(rope) do
      symbol = fn x, y ->
        if {x, y} == rope.head do
          "H"
        else
          tail = rope.tails
            |> Enum.with_index()
            |> Enum.find(fn {{tx, ty}, _} -> x == tx and y == ty end)

          if tail != nil,
            do: elem(tail, 1) + 1,
          else: "."
        end
      end

      col = for y <- 0..4 do
        row = for x <- 0..5 do
          symbol.(x, y)
        end
        Enum.join(row, "")
      end
      map = col
        |> Enum.reverse()
        |> Enum.join("\n")

      IO.puts map
      IO.puts ""

      rope
    end
  end

  defp touching?({x1, y1}, {x2, y2}) do
    abs(x1 - x2) <= 1 and
    abs(y1 - y2) <= 1
  end

  defp step_towards(p1, p2) when p1 == p2, do: p1
  defp step_towards(p1, p2) when p1 <  p2, do: p1 + 1
  defp step_towards(p1, p2) when p1 >  p2, do: p1 - 1

  defp move(rope, dir) do
    head = move_head(rope.head, dir)

    {tails, _} = Enum.map_reduce(rope.tails, head, fn tail, head ->
      tail = move_tail(head, tail)
      {tail, tail}
    end)

    %{rope |
      head: head,
      tails: tails,
      hist: [List.last(tails) | rope.hist],
    }
  end

  defp move_head(head, dir) do
    {x, y} = head
    case dir do
      "U" -> {x, y+1}
      "D" -> {x, y-1}
      "R" -> {x+1, y}
      "L" -> {x-1, y}
    end
  end

  defp move_tail(head, tail) do
    {hx, hy} = head
    {tx, ty} = tail

    if touching?({hx, hy}, {tx, ty}) do
      tail
    else
      {
        step_towards(tx, hx),
        step_towards(ty, hy),
      }
    end
  end

  def part_one(input) do
    input
      |> format
      |> expand
      |> Enum.reduce(Rope.new(1), & move(&2, &1))
      |> Map.get(:hist)
      |> Enum.uniq()
      |> Enum.count()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
      |> format
      |> expand
      |> Enum.reduce(Rope.new(9), & move(&2, &1))
      |> Map.get(:hist)
      |> Enum.uniq()
      |> Enum.count()
  end

end
