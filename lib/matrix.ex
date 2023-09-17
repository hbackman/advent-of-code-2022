defmodule Matrix do

  defstruct [
    :data,
  ]

  @doc """
  Convert a 2d list into a matrix.
  """
  def from_list(list) when is_list(list) do
    %__MODULE__{
      data: list_to_2d_map(list),
    }
  end

  defp list_to_2d_map(list) when is_list(list) do
    {map, _} = Enum.reduce(list, {%{}, 0}, fn i, {map, index} ->
      {put_in(map[index], list_to_2d_map(i)), index + 1}
    end)
    map
  end

  defp list_to_2d_map(list), do: list

  @doc """
  Put a value in the matrix.
  """
  def put(matrix = %__MODULE__{}, x, y, value) do
    %{matrix |
      data: put_in(matrix.data[x][y], value)
    }
  end

  @doc """
  Get a value from the matrix.
  """
  def get(matrix = %__MODULE__{}, x, y) do
    matrix.data[x][y]
  end

end
