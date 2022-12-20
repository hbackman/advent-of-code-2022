defmodule Aoc2022.Day07.Env do

  defstruct [
    path: [],
    tree: %{},
  ]

  @doc """
  Change the current directory.
  """
  def cd(env, dir) do
    case dir do
      "/"  -> %{env | path: ["/"]}
      ".." -> %{env | path: Enum.drop(env.path, 1)}
      dir  -> %{env | path: [dir | env.path]}
    end
  end

  @doc """
  Process "list directory" output.
  """
  def ls(env, out) do
    pwd = Enum.reverse(env.path)

    # Load the directory.
    dir = get_in(env.tree, pwd) || %{}

    # Write the output.
    dir = Enum.reduce(out, dir, fn line, acc ->
      {key, val} = case line do
        "dir " <> f -> {f, %{}}
        ""     <> s -> String.split(s, " ")
          |> Enum.reverse()
          |> List.to_tuple()
      end

      Map.put(acc, key, val)
    end)

    %{env | tree: put_in(env.tree, pwd, dir)}
  end
end

defmodule Aoc2022.Day07 do

  alias Aoc2022.Day07.Env

  defp format(input) do
    input
      |> String.split("$ ", trim: true)
      |> Enum.map(& String.split(&1, ~r/\R/, trim: true))
  end

  defp parse(input),
    do: String.split(input, " ", trim: true)

  defp reduce([], env), do: env

  defp reduce([h | t], env) do
    reduce(t, handle(env, h))
  end

  defp handle(env, [command | output]) do
    case command do
      "cd " <> args -> Env.cd(env, args)
      "ls"  <> _arg -> Env.ls(env, output)
                  _ -> env
    end
  end

  # --------------------------------------------------
  # Part One
  # --------------------------------------------------

  defp search(dir) do
    stats = Enum.reduce(dir, [], fn {name, data}, acc ->
      stat = if is_binary(data) do
        [{:file, name, String.to_integer(data)}]
      else
        {dir_size, dir_stats} = search(data)

        [{:dir, name, dir_size}] ++ dir_stats
      end
      stat ++ acc
    end)

    size = stats
      |> Enum.filter(& elem(&1, 0) == :file)
      |> Enum.map(& elem(&1, 2))
      |> Enum.sum()

    {size, stats}
  end

  def part_one(input) do
    env = input
      |> format()
      |> reduce(%Env{})

    {_, stats} = search(env.tree["/"])

    stats
      |> Enum.filter(& elem(&1, 0) == :dir)
      |> Enum.filter(& elem(&1, 2) < 100000)
      |> Enum.map(& elem(&1, 2))
      |> Enum.sum()
  end
  
  # --------------------------------------------------
  # Part Two
  # --------------------------------------------------
  
  def part_two(input) do
    env = input
      |> format()
      |> reduce(%Env{})

    {rsize, stats} = search(env.tree["/"])

    stats
      |> Enum.filter(& elem(&1, 0) == :dir)
      |> Enum.filter(& elem(&1, 2) > 30000000 - (70000000 - rsize))
      |> Enum.map(& elem(&1, 2))
      |> Enum.sort(&(&1 >= &2))
      |> Enum.min()
  end
    
end