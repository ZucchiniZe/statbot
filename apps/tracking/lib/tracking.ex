defmodule Tracking do
  @moduledoc """
  Documentation for Tracking.
  """
  use GenServer
  alias Nostrum.Api

  require Logger

  ## Client API

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def add_guild(guild) do
    GenServer.cast(__MODULE__, {:add_guild, guild})
  end

  def new_message(message) do
    GenServer.cast(__MODULE__, {:new_message, message})
  end

  ## Server API

  def init(_) do
    files = %{}
    {:ok, files}
  end

  def handle_cast({:add_guild, guild}, files) do
    # Create a map of guilds and their associated files
    time = :os.system_time(:millisecond)
    files = Map.put(files, guild.id, File.open!("data/tracking-guild-#{guild.id}-#{time}.log", [:write]))
    guild_file = files[guild.id]

    # Write a "legend" as the first line of the file
    IO.write(guild_file, "guild id: #{guild.id} name: #{guild.name}\n")

    Logger.log :info, "new guild added"

    {:noreply, files}
  end

  def handle_cast({:new_message, message}, files) do
    # Since we can't tell if the channel is private from the message, we need to make a call to the discord api
    {:ok, channel} = Api.get_channel(message.channel_id)

    # check if the channel is a DM channel
    if channel["type"] == 1 do
      {:noreply, files}
    else
      {_, guild} = Nostrum.Cache.Guild.GuildServer.get(channel_id: message.channel_id)

      file = files[guild.id]

      log_entry = log_string message, channel

      Logger.log :info, "new message ingested"
      Logger.log :debug, log_entry

      IO.write(file, log_entry <> "\n")
      {:noreply, files}
    end
  end

  defp log_string(message, channel) do
    result = "guild:#{channel["guild_id"]},"
    result = result <> "channel:#{channel["id"]},"
    result = result <> "from:#{message.author.id},"
    result = result <> "time:#{message.timestamp}"
    result
  end
end
