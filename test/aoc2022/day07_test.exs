defmodule Aoc2022.Day06Test do

  use ExUnit.Case, async: true

  alias Aoc2022.Day07

  @input [:code.priv_dir(:aoc2022), "day07.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    IO.inspect Day07.part_one(@input)
  end

  describe "part two" do
    IO.inspect Day07.part_two(@input)
  end

end