defmodule Scrabble do
  import String, only: [upcase: 1]

  @scores %{
    "A" => 1,
    "B" => 3,
    "C" => 3,
    "D" => 2,
    "E" => 1,
    "F" => 4,
    "G" => 2,
    "H" => 4,
    "I" => 1,
    "J" => 8,
    "K" => 5,
    "L" => 1,
    "M" => 3,
    "N" => 1,
    "O" => 1,
    "P" => 3,
    "Q" => 10,
    "R" => 1,
    "S" => 1,
    "T" => 1,
    "U" => 1,
    "V" => 4,
    "W" => 4,
    "X" => 8,
    "Y" => 4,
    "Z" => 10
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer

  def score(""), do: 0

  def score(<<first_letter::bytes-size(1)>> <> other_letters) do
    letter_score(first_letter) + score(other_letters)
  end

  defp letter_score(letter) do
    @scores[upcase(letter)] || 0
  end
end
