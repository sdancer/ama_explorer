# lib/amadeus_explorer_web/live/epoch_live.ex
defmodule AmadeusExplorerWeb.EpochLive do
  use AmadeusExplorerWeb, :live_view
  alias AmadeusExplorer.EpochsCache

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    epoch = parse_epoch(id)

    miners =
      safe_read_miners(epoch)
      |> Enum.sort_by(& &1.sols, :desc)

    total = safe_epoch_total(epoch, miners)

    rows =
      Enum.map(miners, fn m ->
        pct =
          if total > 0, do: m.sols * 100.0 / total, else: 0.0

        m = Map.put(m, :percent, pct)
        m = Map.put(m, :comment, AmadeusExplorer.known_addr(m.miner_key))
        Map.put(m, :id, m.miner_key)
      end)

    {:ok,
     socket
     |> assign(epoch: epoch, total: total)
     |> stream(:miners, rows, reset: true, dom_id: &"epoch-#{&1.id}")}
  end

  defp parse_epoch(id) do
    case Integer.parse(id) do
      {i, _} -> i
      _ -> raise ArgumentError, "invalid epoch id"
    end
  end

  defp safe_read_miners(epoch) do
    try do
      EpochsCache.read_epoch_miners(epoch)
    catch
      _ -> []
    end
  end

  defp safe_epoch_total(epoch, miners_fallback) do
    total_from_list =
      try do
        EpochsCache.read_epochs()
      catch
        _ -> []
      end
      |> Enum.find_value(0, fn {e, s} -> if e == epoch, do: s, else: nil end)

    if total_from_list > 0 do
      total_from_list
    else
      Enum.reduce(miners_fallback, 0, fn m, acc -> acc + (m.sols || 0) end)
    end
  end

  defp fmt_int(i) when is_integer(i), do: :erlang.integer_to_binary(i)
  defp fmt_pct(f) when is_float(f), do: :erlang.float_to_binary(f, [:compact, {:decimals, 2}])

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-5xl mx-auto p-6">
      <.link navigate={~p"/epochs"} class="text-sm underline">&larr; Back</.link>
      <h1 class="text-2xl font-bold mb-1">Epoch {@epoch}</h1>
      <div class="text-sm text-zinc-500 mb-4">Total solutions: {@total}</div>

      <div class="rounded border">
        <table class="min-w-full text-sm">
          <thead class="bg-zinc-50">
            <tr>
              <th class="text-left p-2">Miner</th>
              <th class="text-right p-2">Sols</th>
              <th class="text-right p-2">Percent</th>
            </tr>
          </thead>
          <tbody id="miners" phx-update="stream">
            <%= for {dom_id, row} <- @streams.miners do %>
              <tr id={dom_id} class="border-t">
                <td class="p-2 font-mono">{row.miner_key} {row.comment}</td>
                <td class="p-2 text-right font-mono">{fmt_int(row.sols)}</td>
                <td class="p-2 text-right">{fmt_pct(row.percent)}%</td>
              </tr>
            <% end %>
          </tbody>
        </table>
      </div>
    </div>
    """
  end
end
