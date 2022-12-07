defmodule Aoc2022.Day04Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day04

  @input [:code.priv_dir(:aoc2022), "day04.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day04.part_one(@input) == 599
  end

  describe "part two" do
    assert Day04.part_two(@input) == 928
  end

end
