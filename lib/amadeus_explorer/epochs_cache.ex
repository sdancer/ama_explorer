# lib/amadeus_explorer/epochs_cache.ex
defmodule AmadeusExplorer.EpochsCache do
  use GenServer

  ## Public API
  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  def read_epochs(), do: GenServer.call(__MODULE__, :read_epochs)
  def read_epoch_miners(epoch), do: GenServer.call(__MODULE__, {:read_epoch_miners, epoch})

  # Optional writers (handy for wiring real data later)
  def put_epochs(list), do: GenServer.cast(__MODULE__, {:put_epochs, list})

  def put_epoch_miners(epoch, list),
    do: GenServer.cast(__MODULE__, {:put_epoch_miners, epoch, list})

  ## GenServer
  @impl true
  def init(_) do
    :ets.file2tab(:epochs)
    :ets.tab2list(:epochs)

    totals =
      :ets.foldl(
        fn {_miner_id, epochs}, acc ->
          Enum.reduce(epochs, acc, fn {epoch_id, v}, acc2 ->
            Map.update(acc2, epoch_id, v, &(&1 + v))
          end)
        end,
        %{},
        :epochs
      )

    epochs = Enum.sort(totals)
    # Enum.each totals, & IO.inspect(&1)

    # Fill this map with your real breakdowns per epoch.
    # Each list item: %{miner_key: "0x...", sols: integer}
    miners =
      :ets.foldl(
        fn {miner_key, epochs_map}, acc ->
          Enum.reduce(epochs_map, acc, fn {epoch, sols}, acc2 ->
            Map.update(acc2, epoch, [%{miner_key: miner_key, sols: sols}], fn rows ->
              [%{id: miner_key, miner_key: miner_key, sols: sols} | rows]
            end)
          end)
        end,
        %{},
        :epochs
      )
      |> Map.new(fn {epoch, rows} -> {epoch, Enum.sort_by(rows, & &1.sols, :desc)} end)

    {:ok, %{epochs: epochs, miners: miners}}
  end

  @impl true
  def handle_call(:read_epochs, _from, state), do: {:reply, state.epochs, state}

  @impl true
  def handle_call({:read_epoch_miners, epoch}, _from, state) do
    {:reply, Map.get(state.miners, epoch, []), state}
  end

  @impl true
  def handle_cast({:put_epochs, list}, state), do: {:noreply, %{state | epochs: list}}

  @impl true
  def handle_cast({:put_epoch_miners, epoch, list}, state) do
    {:noreply, %{state | miners: Map.put(state.miners, epoch, list)}}
  end
end
