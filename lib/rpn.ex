defmodule Rpn do
  use GenServer

  ### Client API
  def start do
    GenServer.start(__MODULE__, [], [])
  end

  def peek(pid) do
    GenServer.call(pid, :peek)
  end

  def push(pid, item) do
    GenServer.cast(pid, {:push, item})
  end

  ### Server API
  def handle_call(:peek, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:push, :+}, [second | [first | tail]]) do
    {:noreply, [first + second | tail]}
  end
  def handle_cast({:push, :-}, [second | [first | tail]]) do
    {:noreply, [first - second | tail]}
  end
  def handle_cast({:push, :x}, [second | [first | tail]]) do
    {:noreply, [first * second | tail]}
  end
  def handle_cast({:push, item}, state) do
    {:noreply, [item | state]}
  end
end
