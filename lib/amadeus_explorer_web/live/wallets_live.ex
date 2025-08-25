defmodule AmadeusExplorerWeb.WalletsLive do
  use AmadeusExplorerWeb, :live_view
  alias AmadeusExplorer.WalletsCache

  @impl true
  def mount(_params, _session, socket) do
    # if connected?(socket), do: WalletsCache.subscribe()
    wallets = safe_read()

    socket =
      socket
      |> assign(q: "", total: length(wallets))
      |> stream(:wallets, wallets, reset: true)

    {:ok, socket}
  end

  @impl true
  def handle_info({:wallets_updated, wallets}, socket) do
    {:noreply,
     socket
     |> assign(total: length(wallets))
     |> push_stream(wallets, socket.assigns.q)}
  end

  @impl true
  def handle_event("filter", %{"q" => q}, socket) do
    wallets = safe_read()
    {:noreply, push_stream(socket, wallets, q)}
  end

  defp push_stream(socket, list, q) do
    filtered =
      list
      |> maybe_filter(q)
      |> Enum.take(1_000)

    socket
    |> assign(q: q)
    |> stream(:wallets, filtered, reset: true)
  end

  defp safe_read() do
    try do
      WalletsCache.read()
    catch
      _ -> []
    end
  end

  defp maybe_filter(list, ""), do: list

  defp maybe_filter(list, q) do
    qd = String.downcase(q)
    Enum.filter(list, fn %{address: a} -> String.contains?(String.downcase(a), qd) end)
  end

  def format_balance(b) when is_integer(b), do: :erlang.integer_to_binary(b)

  def format_balance(b) when is_float(b) do
    :erlang.float_to_binary(b, [:compact, {:decimals, 6}])
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-5xl mx-auto p-6">
      <h1 class="text-2xl font-bold mb-4">Top 1,000 Wallets</h1>

      <form phx-change="filter" class="mb-4">
        <input
          name="q"
          value={@q}
          type="text"
          placeholder="Filter by address…"
          class="w-full border rounded px-3 py-2"
        />
      </form>

      <div class="text-sm text-zinc-500 mb-2">Showing - of {@total}</div>

      <div class="overflow-x-auto rounded border">
        <table class="min-w-full text-sm">
          <thead class="bg-zinc-50">
            <tr>
              <th class="text-left p-2">#</th>
              <th class="text-left p-2">Address</th>
              <th class="text-right p-2">Balance</th>
            </tr>
          </thead>
          <tbody id="wallets" phx-update="stream">
            <%= for {dom_id, wallet} <- @streams.wallets do %>
              <tr id={dom_id} class="border-t">
                <td class="p-2">dom_id</td>
                <td class="p-2">
                  <.link navigate={~p"/wallets/#{wallet.address}"} class="font-mono underline">
                    {wallet.address}
                  </.link>
                </td>
                <td class="p-2 text-right font-mono">{format_balance(wallet.balance)}</td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
