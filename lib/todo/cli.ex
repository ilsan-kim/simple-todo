defmodule Todo.Cli do
  @file_path Application.compile_env(:todo, :file_path, "./data")
  def file_path() do
    @file_path
  end
  
  def main(argv) do
    parse_args(argv)
  end

  def parse_args(argv, file_path \\ file_path()) do
    OptionParser.parse(argv, switches: [help: :boolean, insert: :string, delete: :string, get: :boolean], aliases: [h: :help, i: :insert, d: :delete, g: :get])
    |> elem(0)
    |> args_to_internal_data(file_path)
  end

  def args_to_internal_data([insert: data], file_path) do
    Todo.Persistence.save(data, file_path)
  end

  def args_to_internal_data([get: _], file_path) do
    Todo.Persistence.get_all(file_path)
    |> IO.puts 
  end

  def args_to_internal_data([delete: index], file_path) do
    Todo.Persistence.delete(index, file_path)
  end

  def args_to_internal_data([help: _], _) do
    IO.puts """
    usage.
    -i (--insert) <task> > insert todo list
    -d (--delete) <task> > delete todo list
    -g (--get) > get all todo list
    """
  end

  def args_to_internal_data(_, file_path) do
    args_to_internal_data([help: ""], file_path)
  end
end
