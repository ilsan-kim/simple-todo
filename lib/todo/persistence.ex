defmodule Todo.Persistence do
  require Timex 
  
  def open_file(path) do
    case File.read(path) do
      {:ok, data} -> 
        data
      {:error, _} -> 
        File.write(path, "")
        IO.puts "no file exists.... generate one...."
        ""
    end
  end

  def save(data, path) do
    open_file(path)
    |> write(data)
    |> save_file(path)
  end 

  def delete(index, path) do
    open_file(path)
    |> remove_character(index)
    |> save_file(path)
  end

  def get(index, path) do
    open_file(path)
    |> get_line(index)
  end

  def get_all(path) do
    open_file(path)
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
    pattern = ~r/\[(\d+)\]/
    case data do
      "" -> 0
      _ -> 
        last = String.split(data, "\n")
        |> Enum.at(-1)
        
        matches = Regex.scan(pattern, last)
        [_, c] = hd(matches)
        String.to_integer(c)
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

  defp remove_character(data, index) do
    t = "[#{index}]"

    String.split(data, "\n")
    |> delete(t, [])
  end
  
  # 첫 루프
  defp delete([head | tail], t, []) do
    case String.starts_with?(head, t) do
      # 첫번째 루프 떄 target 찾으면 head 버리기
      true -> delete(tail, t, Enum.drop(tail, 1))
      # 첫번쨰 루프 때 target 못 찾으면 
      false -> delete(tail, t, [head])
    end  
  end
  # 마지막 루프
  defp delete([], _, res), do: Enum.join(res, "\n")
   
  # 중간 루프
  defp delete([head | tail], t, res) do
    case String.starts_with?(head, t) do
      # 중간 루프 때 target 찾으면 /// haed 버리고... 
      true -> delete(tail, t, res)
      # 중간 루프 때 target 못 찾으면 /// head 를 res 뒤에 붙인다
      false -> delete(tail, t, res++[head])
    end
  end
end
