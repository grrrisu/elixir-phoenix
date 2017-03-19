defmodule Identicon do

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  defp hash_input(input) do
    hash = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hash: hash}
  end

  defp pick_color(%Identicon.Image{hash: [r, g, b | _tail]} = image) do
    %Identicon.Image{ image | color: {r, g, b} }
  end

  defp build_grid(%Identicon.Image{hash: hash} = image) do
    grid =
      hash
      |> Enum.chunk(3)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{ image | grid: grid }
  end

  defp mirrow_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  defp filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Identicon.Image{ image | grid: grid }
  end

  defp build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      x = rem(index, 5) * 50
      y = div(index, 5) * 50
      { {x, y}, {x + 50, y + 50} }
    end

    %Identicon.Image{ image | pixel_map: pixel_map }
  end

  defp draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill  = :egd.color(color)

    Enum.each pixel_map, fn({point1, point2}) ->
      :egd.filledRectangle(image, point1, point2, fill)
    end

    :egd.render(image)
  end

  defp save_image(image, name) do
    File.write("#{name}.png", image)
  end

end
