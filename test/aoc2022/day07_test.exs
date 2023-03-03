defmodule Aoc2022.Day07Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day07

  @input [:code.priv_dir(:aoc2022), "day07.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day07.part_one(@input) == 1611443
  end

  describe "part two" do
    assert Day07.part_two(@input) == 2086088
  end

end