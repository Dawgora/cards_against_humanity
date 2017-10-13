defmodule CardsAgainstHumanity.Cards.WhiteCards do
    use GenServer

    def start_link(options \\ []) do
        GenServer.start_link __MODULE__, [], options
    end

    def show(pid) do
        GenServer.call(pid, {:show})
    end

    ### SERVER SIDE

    def init(_) do
        white = 
        ["CAHe1", "CAHe2"]
        |> (&Enum.flat_map(&1, fn(x) -> readFiles(x, "/white.txt") end)).()

        {:ok, white}
    end

    def handle_call({:show}, _from, state) do
        state
        |> Enum.each ( fn x -> IO.puts x end)
        
        {:reply, :ok, state}
    end

    defp readFiles(pack, file) do
        {:ok, body} = File.read "source/" <> pack <> file
        body |> String.split("\n")
    end
end