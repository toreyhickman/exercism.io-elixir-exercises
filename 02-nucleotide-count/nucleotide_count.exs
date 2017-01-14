defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(nucleotide_strand, type) do
    Enum.count(nucleotides_of_type(nucleotide_strand, type))
  end


  @doc """
  Filters a nucleotide strand to the include only
  nucleotides of a given type.

  ## Examples

  iex> NucleotideCount.nucleotides_of_type('AATA', ?T)
  'T'

  iex> NucleotideCount.nucleotides_of_type('AATA', ?A)
  'AAA'
  """
  @spec nucleotides_of_type([char], char) :: [char]
  def nucleotides_of_type(nucleotide_strand, type) do
    Enum.filter(nucleotide_strand, fn(nucleotide) -> nucleotide == type end)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(nucleotide_strand) do
    Map.new(@nucleotides, fn(type) -> {type, count(nucleotide_strand, type)} end)
  end
end
