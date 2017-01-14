defmodule RunLengthEncoder do
  import Kernel, except: [length: 1]

  import String, only: [length: 1, first: 1, pad_trailing: 3, last: 1, to_integer: 1, slice: 2]
  import List,   only: [flatten: 1]
  import Regex,  only: [scan: 3]
  import Enum,   only: [map: 2, join: 2]

  @unencoded_chunk_pattern ~r/([a-z])\1*/i
  @encoded_chunk_pattern   ~r/(\d+[a-z])/i
  @letter ~r/\d+/


  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string |> chunk_unencoded |> encode_chunks |> join_chunks
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string |> chunk_encoded |> decode_chunks |> join_chunks
  end

  defp chunk_unencoded(string) do
    @unencoded_chunk_pattern |> chunk(string)
  end

  defp chunk_encoded(string) do
    @encoded_chunk_pattern |> chunk(string)
  end

  defp chunk(pattern, string) do
    pattern |> scan(string, capture: :first) |> flatten
  end

  defp encode_chunks(unencoded_chunks) do
    unencoded_chunks |> map(chunk_encoder)
  end

  defp chunk_encoder do
    fn(unencoded_chunk) -> "#{length(unencoded_chunk)}#{first(unencoded_chunk)}" end
  end

  defp decode_chunks(encoded_chunks) do
    encoded_chunks |> map(chunk_decoder)
  end

  defp chunk_decoder do
    fn(encoded_chunk) -> pad_trailing(letter(encoded_chunk), quantity(encoded_chunk), letter(encoded_chunk)) end
  end

  defp letter(encoded_chunk) do
    encoded_chunk |> last
  end

  defp quantity(encoded_chunk) do
    encoded_chunk |> remove_letter |> to_integer
  end

  defp remove_letter(encoded_chunk) do
    encoded_chunk |> slice(0..-2)
  end

  defp join_chunks(chunks) do
    chunks |> join("")
  end
end
