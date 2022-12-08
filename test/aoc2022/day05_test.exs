defmodule Aoc2022.Day05Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day05

  @input [:code.priv_dir(:aoc2022), "day05.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day05.part_one(@input) == "FZCMJCRHZ"
  end

  describe "part two" do
    assert Day05.part_two(@input) == "JSDHQMZGF"
  end

end
