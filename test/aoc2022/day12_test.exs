defmodule Aoc2022.Day12Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day12

  @input [:code.priv_dir(:aoc2022), "day12.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day12.part_one(@input) == 361
  end

  describe "part two" do
    assert Day12.part_two(@input) == 354
  end

end
