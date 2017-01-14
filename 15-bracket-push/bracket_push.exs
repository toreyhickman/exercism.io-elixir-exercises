defmodule BracketPush do
  import Kernel, except: [match?: 2]

  import Regex, only: [match?: 2]
  import List,  only: [last: 1]
  import Enum,  only: [slice: 2, empty?: 1]

  @opener_pattern ~r/[\{\[\(]/
  @closer_pattern ~r/[\}\]\)]/
  @open_close_pattern ~r/(\{\}|\[\]|\(\))/

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
    @opener_pattern |> match?(character)
  end

  defp closer?(character) do
    @closer_pattern |> match?(character)
  end

  defp paired?(nil, _), do: false
  defp paired?(opener, closer) do
    @open_close_pattern |> match?(opener <> closer)
  end

  defp remove_last(openers) do
    slice(openers, 0..-2)
  end
end
