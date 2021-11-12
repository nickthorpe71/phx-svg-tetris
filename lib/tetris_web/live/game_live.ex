defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)

    {
      :ok,
      socket
      |> new_tetromino
      |> show
    }
  end

  def render(assigns) do
    ~L"""
    <% {x, y} = @tetro.location %>
    <section class="phx-hero">
      <h1> Welcome to Tetris</h1>
      <%= render_board(assigns) %>
      <pre>
        {<%= inspect @tetro %>}
      </pre>
    </section>
    """
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(198,236,135);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~L"""
    <%= for {x,y} <- @points do %>
      <rect
        width="20" height="20"
        x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>"
        style="fill:rgb(9,62,0)stroke-width:2;stroke:rgb(45,122,0);"
      />
    <% end %>
    """
  end

  defp new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end

  defp show(socket) do
    assign(socket,
      points: Tetromino.show(socket.assigns.tetro)
    )
  end

  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino
    |> show
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.down(tetro))
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> down |> show}
  end
end
