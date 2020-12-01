defmodule Chatter.Chats.Robots.Diamond do
  import String
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @offset 1
  @dimension_multiplier 2

  @spec build_shape(char) :: String.t()

  def call(body) do
    String.upcase(body)
    |> String.to_charlist
    |> build_shape
  end

  defp build_shape([head | tail]) do
    lines(head - ?A) |> Enum.join
  end

  defp lines(dim), do: Enum.map(-dim..dim, &abs/1) |> Enum.map(&line(&1, dim) <> "\n")
  defp line(padding, dim) when padding == dim, do: duplicate("-", padding) <> <<?A>> <> duplicate("-", padding)
  defp line(padding, dim) do
    letter = <<?A + dim - padding>>

    duplicate("-", padding) <> letter <>
    duplicate("-", @dimension_multiplier * dim - @dimension_multiplier * padding - @offset)
    <> letter <> duplicate("-", padding)
  end
end
