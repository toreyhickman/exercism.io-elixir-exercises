defmodule BracketPush do
  import Kernel, except: [match?: 2]

  import Regex, only: [match?: 2]
  import List,  only: [last: 1]
  import Enum,  only: [slice: 2]

  @opener_pattern ~r/[\{\[\(]/
  @closer_pattern ~r/[\}\]\)]/
  @open_close_pattern ~r/(\{\}|\[\]|\(\))/

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean

  # Define function head to declare default argument values
  def check_brackets(str, openers \\ [])

  # If the string is empty and there are no unclosed openers
  def check_brackets("", []), do: true

  # If the string is empty but there are unclosed openers
  def check_brackets("", _), do: false

  # Default implementation
  def check_brackets(<<first::bytes-size(1)>> <> rest, openers) do
    cond do
      opener?(first) ->
        check_brackets(rest, openers ++ [first])
      closer?(first) ->
        if paired?(last(openers), first), do: check_brackets(rest, remove_last(openers)), else: false
      true ->
        check_brackets(rest, openers)
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
