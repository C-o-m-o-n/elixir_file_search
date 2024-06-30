defmodule FileSearch do
  @moduledoc """
  Documentation for `FileSearch`.
  """
  def main(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [path: :string, query: :string])
    
    case opts do
      [path: path, query: query] ->
      {:ok, pid} = Loader.start_link([])
        search_files(path, query)
        GenServer.stop(pid)
      _-> IO.puts("Usage: file_search --path PATH --query QUERY")
      end
  end
  
  defp search_files(path, query) do
    path
    |> Path.expand()
    |> Path.join("**/*")
    |> Path.wildcard()
    |> Enum.filter(&File.regular?/1)
    # |> Enum.filter(&String.contains?(&1, query))
    # |> Enum.each(&IO.puts/1)
    |> Enum.with_index()
    |> Enum.each(fn {file, index} ->
      if rem(index, 100) == 0 do
        IO.puts("Processed #{index} files...")
      end

      if String.contains?(file, query) do
        IO.puts(file)
      end
    end)
  end
end
