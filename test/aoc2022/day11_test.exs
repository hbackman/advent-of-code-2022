defmodule Aoc2022.Day11Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day11

  @input [:code.priv_dir(:aoc2022), "day11.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day11.part_one(@input) == 182293
  end

  describe "part two" do
    assert Day11.part_two(@input) == 54832778815
  end

end
