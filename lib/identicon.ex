defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> create_image
    |> draw_image
    |> save_image(input)
  end

  defp save_image(image, filename) do
    File.write("#{filename}.png", image)
  end

  defp draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  defp build_pixel_map(grid) do
    Enum.map(grid, fn {_, index} ->
      {hor, ver} = {rem(index, 5) * 50, div(index, 5) * 50}

      {{hor, ver}, {hor + 50, ver + 50}}
    end)
  end

  defp hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end

  defp create_image([r, g, b | _] = hex) do
    import Integer, only: [is_even: 1]

    grid =
      hex
      |> build_grid
      |> Enum.filter(fn {code, _} -> is_even(code) end)

    %Identicon.Image{color: {r, g, b}, grid: grid, pixel_map: build_pixel_map(grid)}
  end

  defp build_grid(hex) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirrow_row/1)
    |> List.flatten()
    |> Enum.with_index()
  end

  defp mirrow_row([first, second | _] = row) do
    row ++ [second, first]
  end
end
