defmodule Gram.Server do
  use GenServer
  alias Gram.Board

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: name)
  end

  def child_spec(name) do
    %{id: name, start: {Gram.Server, :start_link, [name]}}
  end

  def guess(pid, input) do
    GenServer.call(pid, {:guess, input}) |> IO.puts()
  end

  def init(name) do
    IO.puts("Starting game for #{name}")
    {:ok, Board.new()}
  end

  def handle_call({:guess, input}, _from, board) do
    IO.puts("Guessing")
    new_board = Board.guess(board, input)
    {:reply, Board.show(new_board), new_board}
  end
end
