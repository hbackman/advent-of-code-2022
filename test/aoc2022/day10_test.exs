defmodule Aoc2022.Day10Test do

    use ExUnit.Case, async: true
  
    alias Aoc2022.Day10
  
    @input [:code.priv_dir(:aoc2022), "day10.txt"]
      |> Path.join()
      |> File.read!()
  
    describe "part one" do
      assert Day10.part_one(@input) == 15220
    end
  
    describe "part two" do
      IO.inspect Day10.part_two(@input)
      # assert Day10.part_two(@input) == 
    end
  
  end
  