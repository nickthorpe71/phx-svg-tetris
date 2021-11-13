defmodule TetrisWeb.GameLive.GameOver do
  use TetrisWeb, :live_view

  def mount(params, _session, socket) do
    {
      :ok,
      assign(socket, score: params["score"])
    }
  end

  defp restart(socket) do
    push_redirect(socket, to: "/game")
  end

  def handle_event("restart", _, socket) do
    {:noreply, restart(socket)}
  end
end
