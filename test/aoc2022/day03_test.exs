defmodule Aoc2022.Day03Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day03

  @input [:code.priv_dir(:aoc2022), "day03.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day03.part_one(@input) == 8123
  end

  describe "part two" do
    assert Day03.part_two(@input) == 2620
  end

end
