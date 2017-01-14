defmodule Acronym do
  import String, only: [first: 1, replace: 3, split: 3, upcase: 1]

  @non_letters ~r/\P{L}+/
  @letters_preceeding_capital_letter ~r/(\p{L}+)(?=\p{Lu})/U

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(phrase) do
    # Enum.map_join(words(phrase), first_letter)

    phrase |> words |> Enum.map_join(first_letter)
  end

  defp words(phrase) do
    # String.split(clean(phrase), @non_letters, trim: true)

    phrase |> clean |> split(@non_letters, trim: true)
  end

  defp clean(phrase) do
    # String.upcase(separate_camel_case_words(phrase))

    phrase |> separate_camel_case_words |> upcase
  end

  defp separate_camel_case_words(phrase) do
    # String.replace(phrase, @letters_preceeding_capital_letter, "\\1  ")

    phrase |> replace(@letters_preceeding_capital_letter, "\\1 ")
  end

  defp first_letter do
    fn(word) -> first(word) end
  end
end
