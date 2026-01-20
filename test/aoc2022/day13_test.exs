defmodule Aoc2022.Day13Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day13

  @input [:code.priv_dir(:aoc2022), "day13.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    IO.inspect Day13.part_one(@input)
  end

  describe "part two" do
    # assert Day13.part_two(@input) == 354
  end

end
