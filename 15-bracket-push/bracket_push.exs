defmodule BracketPush do
  import List,  only: [last: 1]
  import Enum,  only: [slice: 2, empty?: 1, member?: 2, map: 2]

  @bracket_pairs ["{}", "[]", "()"]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean

  def check_brackets(str, unclosed_openers \\ [])
  def check_brackets("", unclosed_openers), do: empty?(unclosed_openers)
  def check_brackets(<<first::bytes-size(1)>> <> rest, unclosed_openers) do
    cond do
      opener?(first) ->
        check_brackets(rest, unclosed_openers ++ [first])
      closer?(first) ->
        paired?(last(unclosed_openers), first) && check_brackets(rest, remove_last(unclosed_openers))
      true ->
        check_brackets(rest, unclosed_openers)
    end
  end

  defp opener?(character) do
    openers |> member?(character)
  end

  defp closer?(character) do
    closers |> member?(character)
  end

  defp paired?(nil, _), do: false
  defp paired?(opener, closer) do
    @bracket_pairs |> member?(opener <> closer)
  end

  defp openers do
    @bracket_pairs |> map(&(String.first(&1)))
  end

  defp closers do
    @bracket_pairs |> map(&(String.last(&1)))
  end

  defp remove_last(openers) do
    slice(openers, 0..-2)
  end
end
