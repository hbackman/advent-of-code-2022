defmodule Aoc2022.Day09Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day09

  @input [:code.priv_dir(:aoc2022), "day09.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day09.part_one(@input) == 5513
  end

  describe "part two" do
    # assert Day09.part_two(@input) == 1
  end

end
