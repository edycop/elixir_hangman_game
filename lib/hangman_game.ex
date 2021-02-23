defmodule HangManGame do
  def start_game do
    grid = ManageGrid.new_grid()
    word = ManageFiles.read_file('words.txt')
    play(grid, word)
  end

  def play(grid, word) do
    IO.puts("=== HANG GAME ===")
    guest_struct = %HangMan.Guest{}
    while(guest_struct.attempts, grid, word, guest_struct)
  end

  def while(0, _grid, _word, _guest_struct), do: :ok

  def while(ats, grid, word, guest_struct) do
    IO.puts("Word to guest: #{word}")
    IO.puts("Attempts: #{ats}")

    %HangMan.Guest{guest_word: gw, attempts: ats} = guest_struct

    gw =
      if gw == nil do
        String.duplicate("_", String.length(word))
        |> String.split("", trim: true)
      else
        gw
      end

    IO.puts("GW: #{gw}")

    option = IO.gets("Enter a letter (0 to exit): ") |> String.trim()

    guest_result =
      word
      |> String.split("", trim: true)
      |> Enum.map(fn x -> validate_letter(x, option) end)

    IO.puts("GUEST: #{guest_result}")

    guest_or_not =
      guest_result
      |> Enum.all?(fn x -> x == "_" end)

    IO.puts("Guest_or_Not: #{guest_or_not}")

    guest_result =
      if not guest_or_not do
        guest_result
        |> update_result(gw)
      else
        gw
      end

    IO.puts("guest_result: #{guest_result}")

    guest_struct = %HangMan.Guest{guest_struct | guest_word: guest_result}

    IO.inspect(guest_struct)

    paint_hangman(ats, grid)

    ats = ats - 1
    guest_struct = %HangMan.Guest{guest_struct | attempts: ats}

    while(guest_struct.attempts, grid, word, guest_struct)
  end

  def validate_letter(letter, option) do
    case letter == option do
      true -> letter
      false -> "_"
    end
  end

  def update_result(ngw, gw) do
    ngw
    |> Enum.zip(gw)
    |> Enum.map(fn {ngw_char, gw_char} -> compare(ngw_char, gw_char) end)
  end

  def compare(ngw_char, gw_char) do
    case {ngw_char, gw_char} do
      {ngw_char, gw_char} when ngw_char == gw_char -> ngw_char
      {ngw_char, gw_char} when ngw_char == "_" -> gw_char
      {ngw_char, gw_char} when gw_char == "_" -> ngw_char
    end
  end

  def paint_hangman(ats, grid) do
    case ats do
      6 ->
        ManageGrid.paint_grid(grid)

      5 ->
        ManageGrid.head(grid) |> ManageGrid.paint_grid()

      4 ->
        ManageGrid.head(grid) |> ManageGrid.left_hand() |> ManageGrid.paint_grid()

      3 ->
        ManageGrid.head(grid)
        |> ManageGrid.left_hand()
        |> ManageGrid.right_hand()
        |> ManageGrid.paint_grid()

      2 ->
        ManageGrid.head(grid)
        |> ManageGrid.left_hand()
        |> ManageGrid.right_hand()
        |> ManageGrid.body()
        |> ManageGrid.paint_grid()

      1 ->
        ManageGrid.head(grid)
        |> ManageGrid.left_hand()
        |> ManageGrid.right_hand()
        |> ManageGrid.body()
        |> ManageGrid.left_leg()
        |> ManageGrid.paint_grid()

      0 ->
        ManageGrid.head(grid)
        |> ManageGrid.left_hand()
        |> ManageGrid.right_hand()
        |> ManageGrid.body()
        |> ManageGrid.left_leg()
        |> ManageGrid.right_leg()
        |> ManageGrid.paint_grid()
    end
  end
end
