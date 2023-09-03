defmodule PersistnceTest do
  use ExUnit.Case
  import Todo.Persistence
  
  setup_all do
    on_exit(fn -> File.rm!("./test_data") end)
  end

  test "file_path env" do
    assert Todo.Persistence.file_path() == "./data"
  end

  #test "open file" do
  #  assert open_file()
  #end

  test "save" do
    res = save("test todo data", "./test_data")
    file = open_file("./test_data")
    assert res == file
  end

  test "get" do
    res = get(1, "./test_data")
    |> String.contains?("test todo data")
    assert res == true
  end
end
