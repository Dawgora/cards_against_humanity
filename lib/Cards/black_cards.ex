defmodule CardsAgainstHumanity.Cards.BlackCards do
    use GenServer

    def start_link(options \\ []) do
        GenServer.start_link __MODULE__, [], options
    end

    def show(pid) do
        GenServer.call(pid, {:show})
    end

    def pick(pid) do
        GenServer.call(pid, {:pick})
    end

    ### SERVER SIDE

    def init(_) do
        black = 
        ["CAHe1", "CAHe2", "CAHe3", "CAHe4", "CAHe5", "CAHe6"]
        |> (&Enum.flat_map(&1, fn(x) -> readFiles(x, "/black.txt") end)).()

        {:ok, black}
    end

    def handle_call({:show}, _from, state) do
        Enum.each(state, fn(x) -> IO.puts x end)

        {:reply, :ok, state}
    end

    def handle_call({:pick}, _from, []) do
        IO.puts "No cards"
        {:reply, :ok, []}
    end

    def handle_call({:pick}, _from, state) do
        picked = Enum.random(state)
        state = Enum.filter(state, fn(x) -> x != picked end)
        IO.puts picked

        {:reply, :ok, state}
    end

    defp readFiles(pack, file) do
        {:ok, body} = File.read "source/" <> pack <> file
        body |> String.split("\n")
    end
end