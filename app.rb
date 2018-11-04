require 'console_client/console_client'
require 'console_client/console_io'
require 'console_client/game_ui'
require 'console_client/text_provider'

io = io
text_provider = TextProvider.new
ui = GameUI.new(io, text_provider)

client = ConsoleClient::ConsoleClient.new(io, text_provider, ui)
client.start
