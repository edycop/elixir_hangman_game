# Based on https://stackoverflow.com/questions/51342981/how-to-print-a-grid-from-coordinates-like-0-0-in-a-mapset-in-elixir
defmodule ManageGrid do
  def new_grid do
    for col <- 1..5, row <- 1..5, into: %{}, do: {{col, row}, " "}
  end

  def put(grid, {col, row}, val) do
    put(grid, col, row, val)
  end

  def put(grid, col, row, val), do: Map.put(grid, {col, row}, val)

  def fill(grid, list, which) do
    Enum.reduce(list, grid, fn point, acc -> put(acc, point, which) end)
  end

  def paint_grid(grid) do
    for row <- 1..5 do
      for col <- 1..5 do
        " " <> grid[{col, row}]
      end
      |> Enum.join(" |")
    end
    |> Enum.join("\n---+---+---+---+---\n")
    |> IO.puts()
  end

  def head(grid) do
    grid
    |> fill([{3, 1}], "O")
  end

  def left_hand(grid) do
    grid
    |> fill([{1, 2}, {2, 2}], "X")
  end

  def right_hand(grid) do
    grid
    |> fill([{4, 2}, {5, 2}], "X")
  end

  def body(grid) do
    grid
    |> fill([{3, 2}, {3, 3}], "X")
  end

  def left_leg(grid) do
    grid
    |> fill([{2, 4}, {2, 5}], "X")
  end

  def right_leg(grid) do
    grid
    |> fill([{4, 4}, {4, 5}], "X")
  end
end
