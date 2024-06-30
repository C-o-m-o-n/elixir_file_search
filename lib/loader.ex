defmodule Loader do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    schedule_work()
    {:ok, :ok}
  end

  def handle_info(:work, state) do
    print_spinner()
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 100)
  end

  defp print_spinner do
    IO.write("=")
  end
end