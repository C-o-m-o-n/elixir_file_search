defmodule FileSearch do
  @moduledoc """
  Documentation for `FileSearch`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FileSearch.hello()
      :world

  """
  def main(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [path: :string, query: :string])
    
    case opts do
      [path: path, query: query] ->
      search_files(path, query)
      _-> IO.puts("Usage: file_search --path PATH --query QUERY")
      end
  end
  
  defp search_files(path, query) do
    path
    |> Path.expand()
    |> Path.join("**/*")
    |> Path.wildcard()
    |> Enum.filter(&File.regular?/1)
    |> Enum.filter(&String.contains?(&1, query))
    |> Enum.each(&IO.puts/1)
  end
end
