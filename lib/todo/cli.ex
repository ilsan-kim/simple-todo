defmodule Todo.Cli do
  def run(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean, insert: :string], aliases: [h: :help, i: :insert])
    |> elem(0)
    |> args_to_internal_data()
  end

  def args_to_internal_data([insert: data]) do
    IO.puts "insert data... #{data}"
  end

  def args_to_internal_data([help: _]) do
    IO.puts """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list
    """
  end

  def args_to_internal_data(_) do
    args_to_internal_data([help: ""])
  end
end
