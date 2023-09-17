defmodule Aoc2022.Day12Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day12

  @input [:code.priv_dir(:aoc2022), "day12.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    #IO.inspect Day12.part_one(@input)
    Day12.part_one(@input)
    # assert Day12.part_one(@input) == 182293
  end

  describe "part two" do
    # assert Day12.part_two(@input) == 54832778815
  end

end
