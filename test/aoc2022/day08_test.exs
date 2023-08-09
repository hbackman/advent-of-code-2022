defmodule Aoc2022.Day08Test do

    use ExUnit.Case, async: true

    alias Aoc2022.Day08

    @input [:code.priv_dir(:aoc2022), "day08.txt"]
      |> Path.join()
      |> File.read!()

    describe "part one" do
      assert Day08.part_one(@input) == 1859
    end

    describe "part two" do
      #Day08.part_two(@input)
    end

  end
