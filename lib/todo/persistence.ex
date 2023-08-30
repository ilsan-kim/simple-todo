defmodule Todo.Persistence do
  @file_path Application.compile_env(:todo, :file_path, "./data")
  def file_path() do
    @file_path
  end

  def open_file(path \\ file_path()) do
    case File.read(path) do
      {:ok, data} -> IO.puts "success read #{data}"
      {:error, _} -> 
        File.write(path, "")
        IO.puts "no file exists.... generate one...."
    end
  end

  def save(data) do
    
  end 

  def delete(data) do
    
  end

  def get(data) do
    
  end
end
