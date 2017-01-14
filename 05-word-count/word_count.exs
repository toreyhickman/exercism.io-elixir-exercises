defmodule Words do
  @group_of_nonword_chars ~r/[^\p{L}-\d]+/u

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    Enum.reduce(words(sentence), %{}, mark_occurance_of_word)
  end

  defp words(sentence) do
    String.split(clean(sentence), @group_of_nonword_chars, trim: true)
  end

  defp clean(sentence) do
    String.downcase(sentence)
  end

  defp mark_occurance_of_word do
    fn(word, word_counts) -> Map.update(word_counts, word, 1, increment_count) end
  end

  defp increment_count do
    fn(count) -> count + 1 end
  end
end
