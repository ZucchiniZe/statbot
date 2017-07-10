defmodule Bot.Consumer do
  use Nostrum.Consumer
  alias Nostrum.Api
  require Logger

  def start_link do
    Tracking.start_link
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}, state) do
    # case msg.content do
    #   "!test" ->
    #     Api.create_message(msg.channel_id, "I work.... somehow")
    #   _ ->
    #     IO.inspect msg
    # end
    Tracking.new_message msg

    {:ok, state}
  end

  def handle_event({:GUILD_CREATE, {guild}, _ws_state}, state) do
    Tracking.add_guild guild
    {:ok, state}
  end

  def handle_event({event, data, _}, state) do
    # IO.puts String.duplicate("*", 20)
    # IO.puts "inspecting #{event}"
    # IO.inspect data
    # IO.puts String.duplicate("*", 20)
    # IO.puts "recieved #{event}"
    {:ok, state}
  end
end
