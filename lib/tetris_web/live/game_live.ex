defmodule TetrisWeb.GameLive do
  use TetrisWeb, :live_view
  alias Tetris.Tetromino

  @left_keys ["ArrowLeft", "a"]
  @right_keys ["ArrowRight", "d"]

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

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
      <div phx-window-keydown="keystroke">
        <h1> Welcome to Tetris</h1>
        <%= render_board(assigns) %>
        <pre>
          {<%= inspect @tetro %>}
        </pre>
      </div>
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
    <%= for {x, y, shape} <- @points do %>
      <rect
        width="20" height="20"
        x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>"
        style="fill:#<%=color(shape)%>;stroke-width:2;stroke:rgb(45,122,0);"
      />
    <% end %>
    """
  end

  defp color(:l), do: "00237C"
  defp color(:j), do: "300092"
  defp color(:s), do: "600035"
  defp color(:z), do: "461800"
  defp color(:t), do: "272D00"
  defp color(:o), do: "003545"
  defp color(:i), do: "585858"
  defp color(_), do: "093E00"

  defp new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end

  defp show(socket) do
    assign(socket,
      points: Tetromino.show(socket.assigns.tetro)
    )
  end

  def rotate(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.rotate(tetro))
  end

  def left(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.left(tetro))
  end

  def right(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.right(tetro))
  end

  def down(%{assigns: %{tetro: %{location: {_, 20}}}} = socket) do
    socket
    |> new_tetromino
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.down(tetro))
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> down |> show}
  end

  def handle_event("keystroke", %{"key" => " "}, socket) do
    {:noreply, socket |> rotate |> show}
  end

  def handle_event("keystroke", %{"key" => key}, socket) when key in @left_keys do
    {:noreply, socket |> left |> show}
  end

  def handle_event("keystroke", %{"key" => key}, socket) when key in @right_keys do
    {:noreply, socket |> right |> show}
  end
end
