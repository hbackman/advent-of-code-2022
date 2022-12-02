defmodule Aoc2022.Day02Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day02

  @input [:code.priv_dir(:aoc2022), "day02.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day02.part_one(@input) == 14264
  end

  describe "part two" do
    assert Day02.part_two(@input) == 12382
  end

end
