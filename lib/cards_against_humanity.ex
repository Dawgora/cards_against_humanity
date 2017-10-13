defmodule CardsAgainstHumanity do
  use Application


  def start(_type, _args) do
    CardsAgainstHumanity.Cards.Supervisor.start_link(name: Cards.Supervisor)
  end
end
