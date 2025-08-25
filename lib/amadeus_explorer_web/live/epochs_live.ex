# lib/amadeus_explorer_web/live/epochs_live.ex
defmodule AmadeusExplorerWeb.EpochsLive do
  use AmadeusExplorerWeb, :live_view
  alias AmadeusExplorer.EpochsCache

  @impl true
  def mount(_params, _session, socket) do
    epochs = safe_read_epochs()

    {:ok,
     socket
     |> assign(total: length(epochs))
     |> stream(:epochs, epochs, reset: true)}
  end

  defp safe_read_epochs() do
    try do
      EpochsCache.read_epochs()
      |> Enum.map(fn {a, b} ->
        %{epoch: a, sols: b}
      end)
      |> Enum.map(&Map.put(&1, :id, Map.get(&1, :epoch)))
    catch
      _ -> []
    end
  end

  defp fmt_int(i) when is_integer(i), do: :erlang.integer_to_binary(i)

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-5xl mx-auto p-6">
      <h1 class="text-2xl font-bold mb-4">Epochs</h1>

      <div class="text-sm text-zinc-500 mb-2">Total epochs: {@total}</div>

      <div class="overflow-x-auto rounded border">
        <table class="min-w-full text-sm">
          <thead class="bg-zinc-50">
            <tr>
              <th class="text-left p-2">Epoch</th>
              <th class="text-right p-2">Solutions</th>
            </tr>
          </thead>
          <tbody id="epochs" phx-update="stream">
            <%= for {dom_id, row} <- @streams.epochs do %>
              <tr id={dom_id} class="border-t">
                <td class="p-2">
                  <.link navigate={~p"/epoch/#{row.epoch}"} class="underline">
                    {row.epoch}
                  </.link>
                </td>
                <td class="p-2 text-right font-mono">{fmt_int(row.sols)}</td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
