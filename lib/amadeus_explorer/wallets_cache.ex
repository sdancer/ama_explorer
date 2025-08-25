defmodule AmadeusExplorer.WalletsCache do
  @moduledoc false
  use GenServer
  @table :wallets_cache
  @topic "wallets:top1000"
  @limit 1_000
  @refresh_ms 15_000

  def start_link(_), do: GenServer.start_link(__MODULE__, :ok, name: __MODULE__)

  def read, do: :ets.lookup_element(@table, :wallets, 2)
  def subscribe, do: Phoenix.PubSub.subscribe(AmadeusExplorer.PubSub, @topic)

  @impl true
  def init(:ok) do
    :ets.new(@table, [:set, :named_table, :public, read_concurrency: true])
    :ets.insert(@table, {:wallets, []})
    send(self(), :refresh)
    {:ok, %{last_update: nil}}
  end

  @impl true
  def handle_info(:refresh, state) do
    {:noreply, do_refresh(state)}
  end

  defp do_refresh(state) do
    case top_wallets(@limit) do
      {:ok, wallets} ->
        :ets.insert(@table, {:wallets, wallets})
        Phoenix.PubSub.broadcast(AmadeusExplorer.PubSub, @topic, {:wallets_updated, wallets})

      _ ->
        :noop
    end

    Process.send_after(self(), :refresh, @refresh_ms)
    %{state | last_update: System.system_time(:second)}
  end

  def top_wallets(@limit) do
    {:ok,
     [
       %{address: "ama1qxyz...001", id: 0, balance: 123_456},
       %{address: "ama1qxyz...002", id: 1, balance: 98765},
       %{address: "ama1qxyz...003", id: 2, balance: 42000}
     ]}
  end
end
