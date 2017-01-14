defmodule Raindrops do
  import Enum, only: [map_join: 2]

  @sounds %{
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    number |> raindrop_sound
  end

  defp raindrop_sound(number) do
    sound_making_factors
    |> map_join(fn(sound_making_factor) -> sound_for(number, sound_making_factor) end)
    |> ensure_sound(number)
  end

  defp sound_making_factors do
    Map.keys(@sounds)
  end

  defp sound_for(number, possible_factor) do
    if is_factor?(number, possible_factor), do: @sounds[possible_factor], else: ""
  end

  defp is_factor?(dividend, divisor) do
    rem(dividend, divisor) == 0
  end

  defp ensure_sound(sound, number) when sound == "", do: "#{number}"
  defp ensure_sound(sound, _), do: sound
end
