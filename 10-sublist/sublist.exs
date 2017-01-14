defmodule Sublist do
  import List, only: [first: 1]
  import Enum, only: [with_index: 2, map: 2, filter: 2, slice: 3, any?: 2]
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  # Return :equal if the lists are equal
  # Return :sublist if the first list is empty
  # Return :superlist if the second list is empty
  def compare(a, b) when a === b,  do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(a, b) do
    cond do
      is_shorter?(a, b) && is_sublist?(a, b) -> :sublist
      is_shorter?(b, a) && is_sublist?(b, a) -> :superlist
      true                                   -> :unequal
    end
  end

  defp is_shorter?(a, b), do: length(a) < length(b)

  defp is_sublist?(sublist, list) do
    list
    |> possible_sublist_matches(first(sublist), length(sublist))
    |> any_match?(sublist)
  end

  defp possible_sublist_matches(list, value, desired_length) do
    list
    |> indexes_of(value)
    |> map(fn(index) -> slice(list, index, desired_length) end)
  end

  defp indexes_of(list, value) do
    list
    |> with_index(0)
    |> filter(fn({ list_value, _ }) -> list_value == value end)
    |> map(fn({ _ , index}) -> index end)
  end

  defp any_match?(possible_matches, list) do
    any?(possible_matches, fn(possible_match) -> possible_match === list end)
  end
end
