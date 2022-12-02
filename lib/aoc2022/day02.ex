defmodule Aoc2022.Day02 do

  defp fmt(input) do
    input
      |> String.split(~r/\R/)
      |> Enum.map(fn play ->
        [l, r] = String.split(play, " ")
        {l, r}
      end)
  end

  defp match_score(status) do
    case status do
      :win  -> 6
      :draw -> 3
      :lose -> 0
    end
  end

  defp shape_score(shape) do
    case shape do
      "X" -> 1
      "Y" -> 2
      "Z" -> 3
    end
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp play({ l, r }) do
    # A, X -> Rock
    # B, Y -> Paper
    # C, Z -> Scissors
    m = case l do
      "A" -> %{"Y" => :win, "X" => :draw, "Z" => :lose}
      "B" -> %{"Z" => :win, "Y" => :draw, "X" => :lose}
      "C" -> %{"X" => :win, "Z" => :draw, "Y" => :lose}
    end
    match_score(m[r]) + shape_score(r)
  end

  def part_one (input) do
    input
      |> fmt
      |> Enum.map(&play/1)
      |> Enum.sum()
  end

  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------

  defp play2({ l, r }) do
    m = case l do
      "A" -> %{"X" => "Z", "Y" => "X", "Z" => "Y"}
      "B" -> %{"X" => "X", "Y" => "Y", "Z" => "Z"}
      "C" -> %{"X" => "Y", "Y" => "Z", "Z" => "X"}
    end
    play({l, m[r]})
  end

  def part_two (input) do
    input
      |> fmt
      |> Enum.map(&play2/1)
      |> Enum.sum()
  end

end
