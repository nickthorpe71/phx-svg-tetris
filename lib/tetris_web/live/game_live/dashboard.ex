defmodule TetrisWeb.GameLive.Dashboard do
  use TetrisWeb, :live_view
  alias Tetris.Game

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(socket, game: Map.get(socket.assigns, :game) || Game.new())
    }
  end

  defp back_to_main(socket) do
    push_redirect(socket, to: "/game")
  end

  def dashboard(conn, params) do
    query = params["query"] || %{"year" => "2018"}
    inquiries_per_month = InquiryContext.get_inquiries_per_month(query)

    conn
    |> render(
      "dashboard.html",
      inquiries_per_month: inquiries_per_month
    )
  end

  def handle_event("back", _, socket) do
    {:noreply, back_to_main(socket)}
  end
end
