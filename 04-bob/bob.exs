defmodule Bob do
  @any_non_whitespace   ~r/\P{Z}/
  @question_mark_at_end ~r/\?\z/
  @any_letter           ~r/\p{L}/
  @any_lowercase_letter ~r/\p{Ll}/

  @response_for %{
    :shout     => "Whoa, chill out!",
    :silence   => "Fine. Be that way!",
    :statement => "Whatever.",
    :question  => "Sure."
  }

  def hey(message) do
    @response_for[type_of(message)]
  end

  defp type_of(message) do
    cond do
      only_whitespace?(message)      -> :silence
      question_mark_at_end?(message) -> :question
      all_caps?(message)             -> :shout
      true                           -> :statement
    end
  end

  defp only_whitespace?(message) do
    !has_non_whitespace?(message)
  end

  defp has_non_whitespace?(message) do
    message =~ @any_non_whitespace
  end

  defp question_mark_at_end?(message) do
    message =~ @question_mark_at_end
  end

  defp all_caps?(message) do
    has_letter?(message) && all_letters_uppercase?(message)
  end

  defp has_letter?(message) do
    message =~ @any_letter
  end

  defp all_letters_uppercase?(message) do
    !has_lowercase_letter?(message)
  end

  defp has_lowercase_letter?(message) do
    message =~ @any_lowercase_letter
  end
end
