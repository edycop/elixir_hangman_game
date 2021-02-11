defmodule ManageFiles do
  def read_file(filename) do
    {:ok, content} = File.read(filename)
    word_list = content |> String.split("\n", trim: true)
    Enum.random(word_list)
  end
end
