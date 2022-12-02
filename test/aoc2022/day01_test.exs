defmodule Aoc2022.Day01Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day01

  @input [:code.priv_dir(:aoc2022), "day01.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day01.part_one(@input) == 66616
  end

  describe "part two" do
    assert Day01.part_two(@input) == 199172
  end

end
