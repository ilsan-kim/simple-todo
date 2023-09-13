defmodule PersistnceTest do
  use ExUnit.Case
  import Todo.Persistence
  
  setup_all do
    on_exit(fn -> File.rm!("./test_data") end)
  end

  test "save and get" do
    res = save("test todo data", "./test_data")
    file = open_file("./test_data")
    assert res == file
    
    res = get(1, "./test_data")
    |> String.contains?("test todo data")
    assert res == true

    res = delete(1, "./test_data")
    assert res == ""
  end
end
