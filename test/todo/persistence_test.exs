defmodule PersistnceTest do
  use ExUnit.Case
  import Todo.Persistence
  
  test "file_path env" do
    assert Todo.Persistence.file_path() == "./data"
  end

  test "open file" do
    assert open_file()
  end
end

