defmodule Aoc2022.Day06Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day06

  @input [:code.priv_dir(:aoc2022), "day06.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day06.part_one(@input) == 1566
  end

  describe "part two" do
    assert Day06.part_two(@input) == 2265
  end
  
end
  