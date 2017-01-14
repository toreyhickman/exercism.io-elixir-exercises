if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("nucleotide_count.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: true

defmodule NucleotideCountTest do
  use ExUnit.Case

  # @tag :pending
  test "empty dna string has no adenine" do
    assert NucleotideCount.count('', ?A) == 0
  end

  # @tag :pending
  test "repetitive cytosine gets counted" do
    assert NucleotideCount.count('CCCCC', ?C) == 5
  end

  # @tag :pending
  test "counts only thymine" do
    assert NucleotideCount.count('GGGGGTAACCCGG', ?T) == 1
  end

  test "counts zero if no nucleotides of type" do
    assert NucleotideCount.count('', ?A) == 0
  end

  test "filters a nucleotide strand to include only a given type" do
    assert NucleotideCount.nucleotides_of_type('AATA', ?T) == 'T'
  end

  test "filters a nucleotide strand to include only a different given type" do
    assert NucleotideCount.nucleotides_of_type('AATA', ?A) == 'AAA'
  end

  test "filters to an empty strand in no matching nucleotides" do
    assert NucleotideCount.nucleotides_of_type('AATA', ?G) == ''
  end

  test "filters to an equal strand if all nucleotides match" do
    assert NucleotideCount.nucleotides_of_type('AATA', ?G) == ''
  end

  # @tag :pending
  test "empty dna string has no nucleotides" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}
    assert NucleotideCount.histogram('') == expected
  end

  # @tag :pending
  test "repetitive sequence has only guanine" do
    expected = %{?A => 0, ?T => 0, ?C => 0, ?G => 8}
    assert NucleotideCount.histogram('GGGGGGGG') == expected
  end

  # @tag :pending
  test "counts all nucleotides" do
    s = 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC'
    expected = %{?A => 20, ?T => 21, ?C => 12, ?G => 17}
    assert NucleotideCount.histogram(s) == expected
  end
end
