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
      tail: {0, 0},
      hist: [],
    ]

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
      {hx, hy} = rope.head
      {tx, ty} = rope.tail

      col = for y <- 0..4 do
        row = for x <- 0..5 do
          case {x, y} do
            {^hx, ^hy} -> "H"
            {^tx, ^ty} -> "T"
            _ -> "."
          end
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
    rope = rope
      |> move_head(dir)
      |> move_tail()

    %{rope |
      hist: [rope.tail | rope.hist],
    }
  end

  defp move_head(rope, dir) do
    {x, y} = rope.head

    {x, y} = case dir do
      "U" -> {x, y+1}
      "D" -> {x, y-1}
      "R" -> {x+1, y}
      "L" -> {x-1, y}
    end

    %{rope | head: {x, y}}
  end

  defp move_tail(rope) do
    {hx, hy} = rope.head
    {tx, ty} = rope.tail

    if touching?({hx, hy}, {tx, ty}) do
      rope
    else
      %{rope | tail: {
        step_towards(tx, hx),
        step_towards(ty, hy),
      }}
    end
  end

  def part_one(input) do
    input
      |> format
      |> expand
      |> Enum.reduce(%Rope{}, & move(&2, &1))
      |> Map.get(:hist)
      |> Enum.uniq()
      |> Enum.count()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  def part_two(input) do
    input
  end

end
