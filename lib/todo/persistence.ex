defmodule Todo.Persistence do
  require Timex 
  
  @file_path Application.compile_env(:todo, :file_path, "./data")
  def file_path() do
    @file_path
  end

  def open_file(path \\ file_path()) do
    case File.read(path) do
      {:ok, data} -> 
        data
      {:error, _} -> 
        File.write(path, "")
        IO.puts "no file exists.... generate one...."
        ""
    end
  end

  def save(data) do
    open_file(file_path())
    |> write(data)
    |> save_file(file_path())
  end 

  def delete(data) do
    
  end

  def get(index) do
    open_file(file_path())
    |> get_line(index)
  end

  def get_all() do
    open_file(file_path())
  end



  ######################################################
  defp write(data, new_data) do
    id = get_index_of_data(data)
    current_time = get_current_time()
    case id do 
      0 -> "[#{id+1}] " <> new_data <> " " <> current_time
      _ -> data <> "\n" <> "[#{id+1}] " <> new_data <> " " <> current_time 
    end
  end

  defp save_file(data, file_path) do
    case File.write(file_path, data) do
      :ok -> data
      {:error, reason} -> IO.puts "failed to save data. reason #{reason}"
    end
  end
  
  defp get_index_of_data(data) do
    case data do
      "" -> 0
      _ -> 
        String.split(data, "\n")
        |> Enum.count
    end
  end

  defp get_current_time() do
    Timex.now()
    |> Timex.format!("%FT%T%:z", :strftime)
  end

  defp get_line(data, index) do
    String.split(data, "\n")
    |> Enum.at(index - 1)
  end
end

