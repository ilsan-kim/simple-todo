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

    # TODO 이거 테스트 잘 짜기... 중간에 삭제 잘 되게 ....
    save("tdd", "./test_data")
    save("tdd", "./test_data")
    save("tdd", "./test_data")
    save("tdd", "./test_data")
    res = delete(3, "./test_data")
    save("tdd", "./test_data")
    save("tdd", "./test_data")

    res = delete(5, "./test_data")
    IO.puts res
  end
end
