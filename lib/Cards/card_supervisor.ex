defmodule CardsAgainstHumanity.Cards.Supervisor do
    use Supervisor

    def start_link(opts) do
        Supervisor.start_link(__MODULE__, :ok, opts)
    end

    def init(:ok) do
        import Supervisor.Spec, warn: false
  
        children = [
          { CardsAgainstHumanity.Cards.WhiteCards, name: Cards.WhiteCards },
          { CardsAgainstHumanity.Cards.BlackCards, name: Cards.BlackCards }
        ]
  
        opts = [strategy: :one_for_one]
  
        Supervisor.init(children, opts)
      end
end