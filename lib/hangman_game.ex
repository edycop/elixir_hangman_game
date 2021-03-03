defmodule HangManGame do
  def start_game do
    grid = ManageGrid.new_grid()
    word = ManageFiles.read_file('words.txt')
    play(grid, word)
  end

  def play(grid, word) do
    IO.puts("=== HANGMAN GAME ===")
    guess_struct = %HangMan.Guess{}
    while(guess_struct.attempts, grid, word, guess_struct)
  end

  def while(0, _grid, _word, _guess_struct), do: :ok

  def while(ats, grid, word, guess_struct) do
    # IO.puts("Word to guess: #{word}")
    IO.puts("Attempts: #{ats}")

    %HangMan.Guess{guess_word: gw, attempts: ats} = guess_struct

    gw =
      if gw == nil do
        String.duplicate("_", String.length(word))
        |> String.split("", trim: true)
      else
        gw
      end

    # IO.puts("GW: #{gw}")

    option = IO.gets("Enter a letter: ") |> String.trim()

    guess_result =
      word
      |> String.split("", trim: true)
      |> Enum.map(fn x -> validate_letter(x, option) end)

    # IO.puts("GUESS: #{guess_result}")

    guess_or_not =
      guess_result
      |> Enum.all?(fn x -> x == "_" end)

    # IO.puts("Guess_or_Not: #{guess_or_not}")

    guess_result =
      if not guess_or_not do
        guess_result
        |> update_result(gw)
      else
        gw
      end

    # IO.puts("guess_result: #{guess_result}")

    guess_struct = %HangMan.Guess{guess_struct | guess_word: guess_result}

    IO.inspect(guess_struct)

    ats =
      if guess_or_not do
        ats - 1
      else
        ats
      end

    paint_hangman(ats, grid)

    guess_struct = %HangMan.Guess{guess_struct | attempts: ats}

    incomplete =
      guess_result
      |> Enum.any?(fn x -> x == "_" end)

    ats =
      if not incomplete do
        0
      else
        guess_struct.attempts
      end

    while(ats, grid, word, guess_struct)
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
        grid |> ManageGrid.paint_grid()

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
