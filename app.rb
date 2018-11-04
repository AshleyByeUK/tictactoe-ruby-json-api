require 'console_client/console_client'
require 'console_client/console_io'
require 'console_client/game_ui'
require 'console_client/text_provider'

io = ConsoleClient::ConsoleIO.new
text_provider = ConsoleClient::TextProvider
ui = ConsoleClient::GameUI.new(io, text_provider)

client = ConsoleClient::ConsoleClient.new(io, text_provider, ui)
client.start
