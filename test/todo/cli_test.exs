defmodule CliTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Todo.Cli

  test "insert -> insert -> delete -> get_all" do
    # insert 1
    result = parse_args(["-i", "eat pizza"], "./cli_test")
    assert String.contains?(result, "[1] eat pizza") == true
    # insert 2
    result = parse_args(["-i", "eat malayaxie"], "./cli_test")
    assert String.contains?(result, "[2] eat malayaxie") == true
    # delete 1
    result = parse_args(["-d", "1"], "./cli_test")
    assert String.starts_with?(result, "[2]") == true
    # inser 3
    result = parse_args(["-i", "eat shabushabu"], "./cli_test")
    assert String.contains?(result, "[3] eat shabushabu")
    # get_all
    result = parse_args(["-g"], "./cli_test")
    assert String.starts_with?(result, "[2] eat malayaxie") == true
    
    # delete file 
    File.rm!("./cli_test")
  end

  test "-h flag" do
    result = capture_io fn ->
      parse_args(["-h", ""])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list
    -g (--get) > get all todo list\n
    """

    result = capture_io fn ->
      parse_args(["--help", ""])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list
    -g (--get) > get all todo list\n
    """
  end

  test "no predefined flag" do
    result = capture_io fn ->
      parse_args(["some flag", "fasdf"])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list
    -g (--get) > get all todo list\n
    """
  end

  test "no predefined flag#2" do
    result = capture_io fn ->
      parse_args(["--some flag", "fasdf"])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list
    -g (--get) > get all todo list\n
    """
  end

  test "file_path env" do
    assert Todo.Cli.file_path() == "./data"
  end
end

