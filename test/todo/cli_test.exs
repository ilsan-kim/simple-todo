defmodule CliTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Todo.Cli

  test "-i flag" do
    result = capture_io fn ->
      parse_args(["-i", "eat pizza"])
    end
    assert result == "insert data... eat pizza\n"

    result = capture_io fn ->
      parse_args(["--insert", "eat pizza"])
    end
    assert result == "insert data... eat pizza\n"
  end

  test "-h flag" do
    result = capture_io fn ->
      parse_args(["-h", ""])
    end
    assert result == """ 
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list\n
    """

    result = capture_io fn ->
      parse_args(["--help", ""])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list\n
    """
  end

  test "no predefined flag" do
    result = capture_io fn ->
      parse_args(["some flag", "fasdf"])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list\n
    """
  end

  test "no predefined flag#2" do
    result = capture_io fn ->
      parse_args(["--some flag", "fasdf"])
    end
    assert result == """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list\n
    """
  end
end
