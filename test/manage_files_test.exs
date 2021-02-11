defmodule ManageFilesTest do
  use ExUnit.Case

  test "read plain text file" do
    assert ManageFiles.read_file('words.txt') && :true
    # assert ManageFiles.read_file('words.txt') not in [false, nil]
  end
end
